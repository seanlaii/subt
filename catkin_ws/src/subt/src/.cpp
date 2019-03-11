#include "depth_to_point.h"

// void depth_to_point::generate_pointcloud(PointXYZRGB::Ptr point){
// 	/*Decode text pointcloud and text direction
// 	*/
// 	std_msgs::Float32MultiArray pointarray = text_segment_msg.pc_array;
// 	geometry_msgs::Vector3 text_pose_x = text_segment_msg.text_direc;
// 	point->points.resize(pointarray.layout.dim[0].size/7) ;
// 	point->height = 1;
// 	point->width = pointarray.layout.dim[0].size/7;
// 	point->header.frame_id = "camera1_color_optical_frame";
// 	int count = 0;
// 	for (int i=0;i<pointarray.layout.dim[0].size/7;i++){
// 		point->points[i].x=pointarray.data[count++];
// 		point->points[i].y=pointarray.data[count++];
// 		point->points[i].z=pointarray.data[count++];
// 		point->points[i].r=pointarray.data[count++];
// 		point->points[i].g=pointarray.data[count++];
// 		point->points[i].b=pointarray.data[count++];
// 		count++;
// 	}

// 	std::vector<int> indices;
// 	sensor_msgs::PointCloud2 object_cloud_msg;
// 	pcl::toROSMsg(*point, object_cloud_msg);
// 	obstacle_cloud_publisher.publish(object_cloud_msg);
// 	pcl::removeNaNFromPointCloud(*point, *point, indices);
// 	return ;
// }

void depth_to_point::getXYZ(float* a, float* b,float zc){

	float inv_fx = 1.0/fx;
	float inv_fy = 1.0/fy;
	*a = (*a - cx) * zc * inv_fx;
	*b = (*b - cy) * zc * inv_fy;
	return;
}
void depth_to_point::callback(const sensor_msgs::ImageConstPtr& msg_depth){
	
	pc.reset(new PointCloud<PointXYZRGB>());
	cv_bridge::CvImagePtr img_ptr_depth;
	img_ptr_depth = cv_bridge::toCvCopy(msg_depth, sensor_msgs::image_encodings::TYPE_16UC1);
	// cv::Mat& mat_depth = img_ptr_depth->image;
	sensor_msgs::ImageConstPtr image_msg = ros::topic::waitForMessage<sensor_msgs::Image>("/camera/color/image_rect_color",ros::Duration(10));
	//cout << image_msg->encoding << endl;
	cv_bridge::CvImagePtr img_ptr_img = cv_bridge::toCvCopy(image_msg, sensor_msgs::image_encodings::RGB8);
	for( int nrow = 0; nrow < img_ptr_depth->image.rows; nrow++){  
       for(int ncol = 0; ncol < img_ptr_depth->image.cols; ncol++){  
       	if (img_ptr_depth->image.at<int>(nrow,ncol) > 0){
       		
       		pcl::PointXYZRGB point;
       		float* x = new float(nrow);
       		float* y = new float(ncol);

       	 	float z = img_ptr_depth->image.at<int>(nrow,ncol)/10000000.;
       	 	//cout << z << endl;

       		getXYZ(y,x,z);
       		//cout <<"x = "<< *x << endl << "y = " << *y << endl << "z = "<< z  << endl;
       		point.x = z;
       		point.y = *x;
       		point.z = *y;
       		cout << nrow << "  " << ncol << endl ;
       		Vec3b intensity =  img_ptr_img->image.at<Vec3b>(cv::Point(nrow, ncol));
       		cout << int(intensity[0]) << "  " << int(intensity[1]) << "  " << int(intensity[2]) << endl;
  
       		point.r = int(intensity[0]);
       		point.g = int(intensity[1]);
       		point.b = int(intensity[2]);
       		pc->points.push_back(point);


       	} 
       }  
    } 
    cout << pc->points.size() << endl;
    sensor_msgs::PointCloud2 object_cloud_msg;
    toROSMsg(*pc, object_cloud_msg);
    object_cloud_msg.header.frame_id = "camera_link";
    pc2.publish(object_cloud_msg);


	// cout << "the element type of depth_pic is " << pic_type << endl;

	// for( int nrow = 0; nrow < mat_depth.rows; nrow++)  
 //   {  
 //       for(int ncol = 0; ncol < mat_depth.cols; ncol++)  
 //       {  
 //        cout<<mat_depth.at<int>(nrow,ncol);      
 //       }  
 //   } 


	return;
}
depth_to_point::depth_to_point(){
	NodeHandle nh;
	pc2 = nh.advertise<sensor_msgs::PointCloud2> ("/pc", 10);
	depth_image = nh.subscribe<sensor_msgs::Image>("/depth_image", 1, &depth_to_point::callback,this); 
	

}
void depth_to_point::get_msg(){
	sensor_msgs::CameraInfo::ConstPtr msg = ros::topic::waitForMessage<sensor_msgs::CameraInfo>("/camera/color/camera_info",ros::Duration(10));
	fx = msg->P[0];
	fy = msg->P[5];
	cx = msg->P[2];
	cy = msg->P[6];
	//cout << fx << fy << cx << cy << endl;
	return;
}
// msg = rospy.wait_for_message('/X1/rgbd_camera/rgb/camera_info', CameraInfo, timeout=None)
// 		self.fx = msg.P[0]
// 		self.fy = msg.P[5]
// 		self.cx = msg.P[2]
// 		self.cy = msg.P[6]
int main(int argc, char** argv){
    init(argc, argv, "depth_to_point");
    depth_to_point depth_to_point;
    depth_to_point.get_msg();
    spin();
    return 0;
}