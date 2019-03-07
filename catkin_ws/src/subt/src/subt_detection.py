#!/usr/bin/env python
import numpy as np
import cv2
import roslib
import rospy
import tf
import struct
import math
import time
from sensor_msgs.msg import Image
from sensor_msgs.msg import CameraInfo, CompressedImage, PointCloud2
from geometry_msgs.msg import PoseArray, PoseStamped, Point
from visualization_msgs.msg import Marker, MarkerArray
import rospkg
from nav_msgs.msg import Path
from cv_bridge import CvBridge, CvBridgeError
import torch
import torch.nn as nn
import torch.backends.cudnn as cudnn
from torch.autograd import Variable
from ssd import build_ssd
import message_filters
from subt.msg import Object_position_list

class SUBT_detection():
	def __init__(self):
		#self.node_name = rospy.get_name()
		#rospy.loginfo("[%s] Initializing " %(self.node_name))
		self.bridge = CvBridge()
		self.object_position_list = Object_position_list()
		self.is_compressed = False
		# Image definition
		self.width = 640
		self.height = 480
		self.labels = ['background' ,'backpack', 'radio', 'toolbox']
		self.prob_threshold = 0.3
		self.objects = []
		self.net = build_ssd('test', 300, 4)    # initialize SSD
		self.net.load_weights('/home/seanlai-laptop/subt/catkin_ws/src/subt/ssd_model/subt_3000.pth')
		if torch.cuda.is_available():
			self.net = self.net.cuda()
		#img = cv2.imread("radio.jpg")
		msg = rospy.wait_for_message('/X1/rgbd_camera/rgb/camera_info', CameraInfo, timeout=None)
		self.fx = msg.P[0]
		self.fy = msg.P[5]
		self.cx = msg.P[2]
		self.cy = msg.P[6]
		self.points = []
		self.vis_pub = rospy.Publisher('/visualization_marker_array', MarkerArray, queue_size=10)
		#self.image_sub = message_filters.Subscriber("/camera/rgb/image_rect_color", Image)
		self.depth_sub = message_filters.Subscriber("/X1/rgbd_camera/depth/image_raw", Image)
		self.image_sub = message_filters.Subscriber("/X1/rgbd_camera/rgb/image_raw", Image)
		self.ts = message_filters.ApproximateTimeSynchronizer([self.image_sub, self.depth_sub], 1, 0.3)
		self.ts.registerCallback(self.img_cb)
		self.obj_pos_pub = rospy.Publisher("/object_position_list",Object_position_list,queue_size=1)
		self.image_pub = rospy.Publisher("/predict_img", Image, queue_size = 1)

	def img_cb(self, rgb_data, depth_data):
		try:
			if self.is_compressed:
				np_arr = np.fromstring(rgb_data.data, np.uint8)
				cv_image = cv2.imdecode(np_arr, cv2.IMREAD_COLOR)
			else:
				cv_image = self.bridge.imgmsg_to_cv2(rgb_data, "bgr8")

				cv_depthimage = self.bridge.imgmsg_to_cv2(depth_data, "32FC1")
        		cv_depthimage2 = np.array(cv_depthimage, dtype=np.float32)

		except CvBridgeError as e:
			print(e)
		(rows, cols, channels) = cv_image.shape
		self.width = cols
		self.height = rows
		predict_img = self.predict(cv_image, cv_depthimage2)
		try:
			self.image_pub.publish(self.bridge.cv2_to_imgmsg(predict_img, "bgr8"))
			self.obj_pos_pub.publish(self.object_position_list)
			self.objects = []
			self.points = []
		except CvBridgeError as e:
			print(e)

	def predict(self, img, depth_img):
		# Preprocessing
		image = cv2.cvtColor(img, cv2.COLOR_RGB2BGR)
		x = cv2.resize(image, (300, 300)).astype(np.float32)
		x -= (104.0, 117.0, 123.0)
		x = x.astype(np.float32)
		x = x[:, :, ::-1].copy()
		x = torch.from_numpy(x).permute(2, 0, 1)

		#SSD Forward Pass
		xx = Variable(x.unsqueeze(0))     # wrap tensor in Variable
		if torch.cuda.is_available():
			xx = xx.cuda()
		y = self.net(xx)
		scale = torch.Tensor(img.shape[1::-1]).repeat(2)
		detections = y.data	# torch.Size([1, 4, 200, 5]) --> [batch?, class, object, coordinates]
		objs = []
		for i in range(detections.size(1)): # detections.size(1) --> class size
			for j in range(5):	# each class choose top 5 predictions
				if detections[0, i, j, 0].numpy() > self.prob_threshold:
					score = detections[0, i, j, 0]
					pt = (detections[0, i, j,1:]*scale).cpu().numpy()
					objs.append([pt[0], pt[1], pt[2]-pt[0]+1, pt[3]-pt[1]+1, i])
		for obj in objs:
			if obj[4] == 0:
				color = (0, 255, 255)
			elif obj[4] == 1:
				color = (255, 255, 0)
			elif obj[4] == 2:
				color = (255, 0, 255)
			else:
				color = (0, 0, 0)
			cv2.rectangle(img, (int(obj[0]), int(obj[1])),(int(obj[0] + obj[2]), int(obj[1] + obj[3])), color, 3)
			
			if not math.isnan(depth_img[int(obj[1] + obj[3]/2)][int(obj[0] + obj[2]/2)]) :
				zc = depth_img[int(obj[1] + obj[3]/2)][int(obj[0] + obj[2]/2)]
				object_position = self.getXYZ(obj[0] + obj[2]/2, obj[1] + obj[3]/2, zc)
				#TODO:
				point = Point()
				point.x = float(object_position[0])
				point.y = float(object_position[1])
				point.z = float(object_position[2])
				self.object_position_list.position.append(point)
				print ('Object: %s Position: %f, %f, %f' % (self.labels[obj[4]], point.x, point.y, point.z))
				self.object_position_list.object_name.append(self.labels[obj[4]])
			
			cv2.putText(img, self.labels[obj[4]], (int(obj[0] + obj[2]), int(obj[1])), 0, 1, color,2)
			self.points.append(point)
		self.vis_pub.publish(self.createMarkerArray(self.points))

		#print(self.labels[obj[4]])
		#cv2.imshow('image',img)
		#cv2.waitKey(0)
		#cv2.destroyAllWindows()
		return img

	def getXYZ(self,xp, yp, zc):
	    #### Definition:
	    # cx, cy : image center(pixel)
	    # fx, fy : focal length
	    # xp, yp: index of the depth image
	    # zc: depth
	    inv_fx = 1.0/self.fx
	    inv_fy = 1.0/self.fy
	    x = (xp-self.cx) *  zc * inv_fx
	    y = (yp-self.cy) *  zc * inv_fy
	    z = zc
	    return (x,y,z)
	def createMarkerArray(self, points):
		markerArray = MarkerArray()
		count = 0 
		for p in points:
			marker = Marker()
			marker.header.frame_id = "X1/rgbd_camera_frame_optical"
			marker.type = marker.SPHERE
			marker.action = marker.ADD
			marker.id = count
			marker.scale.x = 0.1
			marker.scale.y = 0.1
			marker.scale.z = 0.1
			marker.color.a = 1.0
			marker.color.r = 1.0;
			marker.color.g = 0.0;
			marker.color.b = 0.0;
			marker.pose.orientation.w = 1.0
			marker.pose.position.x = p.x
			marker.pose.position.y = p.y
			marker.pose.position.z = p.z
			count += 1
			markerArray.markers.append(marker)

		return markerArray

if __name__ == '__main__':
	rospy.init_node('subt_detection')
	foo = SUBT_detection()
	rospy.spin()