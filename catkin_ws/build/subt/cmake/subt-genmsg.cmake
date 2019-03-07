# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "subt: 1 messages, 0 services")

set(MSG_I_FLAGS "-Isubt:/home/seanlai-laptop/subt/catkin_ws/src/subt/msg;-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/kinetic/share/geometry_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(subt_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/seanlai-laptop/subt/catkin_ws/src/subt/msg/Object_position_list.msg" NAME_WE)
add_custom_target(_subt_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "subt" "/home/seanlai-laptop/subt/catkin_ws/src/subt/msg/Object_position_list.msg" "geometry_msgs/Point"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(subt
  "/home/seanlai-laptop/subt/catkin_ws/src/subt/msg/Object_position_list.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/subt
)

### Generating Services

### Generating Module File
_generate_module_cpp(subt
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/subt
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(subt_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(subt_generate_messages subt_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/seanlai-laptop/subt/catkin_ws/src/subt/msg/Object_position_list.msg" NAME_WE)
add_dependencies(subt_generate_messages_cpp _subt_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(subt_gencpp)
add_dependencies(subt_gencpp subt_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS subt_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(subt
  "/home/seanlai-laptop/subt/catkin_ws/src/subt/msg/Object_position_list.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/subt
)

### Generating Services

### Generating Module File
_generate_module_eus(subt
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/subt
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(subt_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(subt_generate_messages subt_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/seanlai-laptop/subt/catkin_ws/src/subt/msg/Object_position_list.msg" NAME_WE)
add_dependencies(subt_generate_messages_eus _subt_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(subt_geneus)
add_dependencies(subt_geneus subt_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS subt_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(subt
  "/home/seanlai-laptop/subt/catkin_ws/src/subt/msg/Object_position_list.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/subt
)

### Generating Services

### Generating Module File
_generate_module_lisp(subt
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/subt
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(subt_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(subt_generate_messages subt_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/seanlai-laptop/subt/catkin_ws/src/subt/msg/Object_position_list.msg" NAME_WE)
add_dependencies(subt_generate_messages_lisp _subt_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(subt_genlisp)
add_dependencies(subt_genlisp subt_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS subt_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(subt
  "/home/seanlai-laptop/subt/catkin_ws/src/subt/msg/Object_position_list.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/subt
)

### Generating Services

### Generating Module File
_generate_module_nodejs(subt
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/subt
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(subt_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(subt_generate_messages subt_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/seanlai-laptop/subt/catkin_ws/src/subt/msg/Object_position_list.msg" NAME_WE)
add_dependencies(subt_generate_messages_nodejs _subt_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(subt_gennodejs)
add_dependencies(subt_gennodejs subt_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS subt_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(subt
  "/home/seanlai-laptop/subt/catkin_ws/src/subt/msg/Object_position_list.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/subt
)

### Generating Services

### Generating Module File
_generate_module_py(subt
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/subt
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(subt_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(subt_generate_messages subt_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/seanlai-laptop/subt/catkin_ws/src/subt/msg/Object_position_list.msg" NAME_WE)
add_dependencies(subt_generate_messages_py _subt_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(subt_genpy)
add_dependencies(subt_genpy subt_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS subt_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/subt)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/subt
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(subt_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(subt_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/subt)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/subt
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(subt_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(subt_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/subt)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/subt
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(subt_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(subt_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/subt)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/subt
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(subt_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(subt_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/subt)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/subt\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/subt
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(subt_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(subt_generate_messages_py geometry_msgs_generate_messages_py)
endif()
