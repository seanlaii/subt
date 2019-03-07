#!/usr/bin/env python
import numpy as np
import cv2
import roslib
import rospy
import tf
import struct
import math
import time
from sensor_msgs import point_cloud2
from sensor_msgs.msg import Image
from sensor_msgs.msg import CameraInfo, CompressedImage, PointCloud2, PointField
from geometry_msgs.msg import PoseArray, PoseStamped, Point
import rospkg
from nav_msgs.msg import Path
from cv_bridge import CvBridge, CvBridgeError
from std_msgs.msg import Header


class PointCloud2Depth():
	def __init__(self):
		#rospy.loginfo("[%s] Initializing " %(self.node_name))
		self.bridge = CvBridge()
		msg = rospy.wait_for_message('/X1/rgbd_camera/rgb/camera_info', CameraInfo, timeout=None)
		self.fx = msg.P[0]
		self.fy = msg.P[5]
		self.cx = msg.P[2]
		self.cy = msg.P[6]
		print msg.P
		self.pointcloud_sub = rospy.Subscriber("/X1/points", PointCloud2, self.point_cb, queue_size = 1, buff_size = 2**24)
		self.depth_pub = rospy.Publisher("/depthimage_transformed", Image, queue_size=1)
		self.points = []
	def point_cb(self, point_data):
		gen = point_cloud2.read_points(point_data)
		depth_data = np.zeros((480,640), dtype=np.float32)
		print type(gen)
		for p in gen:
			point = self.inverseXYZ(p[0],p[1],p[2])
			print p
			print point
			depth_data[point[0]][point[1]] = point[2]

		depthimage = self.bridge.cv2_to_imgmsg(depth_data, "32FC1")

		 
		# for x in range(cv_depthimage2.shape[0]):
		# 	for y in range(cv_depthimage2.shape[1]):
		# 		zc = cv_depthimage2[x][y]
		# 		position = self.getXYZ(y, x, zc)
		# 		pt = [position[0],position[1],position[2],0]
		# 		self.points.append(pt)
		# header = Header()
		# header.stamp = rospy.Time.now()
		# header.frame_id = "X1/rgbd_camera_frame_optical"
		self.depth_pub.publish(depthimage)

	def inverseXYZ(self, xc, yc, zc):
	    #### Definition:
	    # cx, cy : image center(pixel)
	    # fx, fy : focal length
	    # xp, yp: index of the depth image
	    # zc: depth
	    inv_zc = 1.0/zc
	    x = self.fx*xc*inv_zc + self.cx
	    y = self.fy*yc*inv_zc + self.cy
	    z = zc
	    return (int(x),int(y),int(z))

if __name__ == '__main__':
	rospy.init_node('PointCloud2Depth')
	foo = PointCloud2Depth()
	rospy.spin()