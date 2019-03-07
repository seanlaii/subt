
(cl:in-package :asdf)

(defsystem "subt-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
)
  :components ((:file "_package")
    (:file "Object_position_list" :depends-on ("_package_Object_position_list"))
    (:file "_package_Object_position_list" :depends-on ("_package"))
  ))