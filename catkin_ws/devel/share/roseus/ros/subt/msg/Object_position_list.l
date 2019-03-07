;; Auto-generated. Do not edit!


(when (boundp 'subt::Object_position_list)
  (if (not (find-package "SUBT"))
    (make-package "SUBT"))
  (shadow 'Object_position_list (find-package "SUBT")))
(unless (find-package "SUBT::OBJECT_POSITION_LIST")
  (make-package "SUBT::OBJECT_POSITION_LIST"))

(in-package "ROS")
;;//! \htmlinclude Object_position_list.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass subt::Object_position_list
  :super ros::object
  :slots (_object_name _position ))

(defmethod subt::Object_position_list
  (:init
   (&key
    ((:object_name __object_name) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:position __position) (let (r) (dotimes (i 0) (push (instance geometry_msgs::Point :init) r)) r))
    )
   (send-super :init)
   (setq _object_name __object_name)
   (setq _position __position)
   self)
  (:object_name
   (&optional __object_name)
   (if __object_name (setq _object_name __object_name)) _object_name)
  (:position
   (&rest __position)
   (if (keywordp (car __position))
       (send* _position __position)
     (progn
       (if __position (setq _position (car __position)))
       _position)))
  (:serialization-length
   ()
   (+
    ;; string[] _object_name
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _object_name)) 4
    ;; geometry_msgs/Point[] _position
    (apply #'+ (send-all _position :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string[] _object_name
     (write-long (length _object_name) s)
     (dolist (elem _object_name)
       (write-long (length elem) s) (princ elem s)
       )
     ;; geometry_msgs/Point[] _position
     (write-long (length _position) s)
     (dolist (elem _position)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string[] _object_name
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _object_name (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _object_name i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; geometry_msgs/Point[] _position
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _position (let (r) (dotimes (i n) (push (instance geometry_msgs::Point :init) r)) r))
     (dolist (elem- _position)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get subt::Object_position_list :md5sum-) "6b35b8256c7ef7f810870db79f7ad15a")
(setf (get subt::Object_position_list :datatype-) "subt/Object_position_list")
(setf (get subt::Object_position_list :definition-)
      "string[] object_name
geometry_msgs/Point[] position
================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :subt/Object_position_list "6b35b8256c7ef7f810870db79f7ad15a")


