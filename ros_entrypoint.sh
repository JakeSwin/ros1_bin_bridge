#!/bin/bash
set -e

source /opt/ros/noetic/setup.bash
source /opt/ros/foxy/setup.bash

rosparam load /bridge.yaml
ros2 run ros1_bridge parameter_bridge