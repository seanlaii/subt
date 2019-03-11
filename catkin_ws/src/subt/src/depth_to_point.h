#include <ros/ros.h>
#include <vector>
#include <sensor_msgs/PointCloud2.h>
#include <sensor_msgs/CameraInfo.h>
#include <sensor_msgs/Image.h>
#include <pcl_conversions/pcl_conversions.h>
#include <pcl/point_cloud.h>
#include <pcl/point_types.h>
#include <cv_bridge/cv_bridge.h>
#include <opencv2/highgui/highgui.hpp>

using namespace ros;
using namespace std;
using namespace cv;
using namespace pcl;

class depth_to_point{
  public:
    depth_to_point();
    //void generate_pointcloud(PointCloud<PointXYZRGB>::Ptr);
    void get_msg();
    void callback(const sensor_msgs::ImageConstPtr&);
    void getXYZ(float* , float* ,float );
  private:
  	Publisher pc2;
  	Subscriber depth_image;
    PointCloud<PointXYZRGB>::Ptr pc;

  	float fx;
  	float fy;
  	float cx;
  	float cy;
};