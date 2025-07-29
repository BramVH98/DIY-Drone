#!/bin/bash

set -e  # Exit script on error

# Update system
sudo apt update && sudo apt upgrade -y

# Install Python and pip
sudo apt install -y python3 python3-pip

# Python packages (using --user so you don’t need sudo)
pip3 install --user kconfiglib pyserial empy toml numpy pandas jinja2 pyyaml pyros-genmsg packaging

# GStreamer dependencies
sudo apt install -y \
  libgstreamer-plugins-base1.0-dev \
  gstreamer1.0-plugins-{bad,base,good,ugly}

# MAVROS and other ROS dependencies
sudo apt install -y \
  libprotobuf-dev libprotoc-dev protobuf-compiler \
  libeigen3-dev libxml2-utils \
  python3-rospkg python3-jinja2 \
  ros-noetic-mavros ros-noetic-mavros-extras \
  ros-noetic-mavlink python3-catkin-tools python3-rosinstall-generator

# GeographicLib datasets for MAVROS
wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh
sudo bash ./install_geographiclib_datasets.sh
rm install_geographiclib_datasets.sh

# PX4 workspace setup
cd ~
mkdir -p ros/firmware_ws/src
cd ros/firmware_ws
catkin init

cd src
git clone https://github.com/PX4/PX4-Autopilot.git --recursive
cd PX4-Autopilot
# Optional: checkout specific version
# git checkout v1.14.0

# Add environment setup to .bashrc
echo "source ~/ros/firmware_ws/src/PX4-Autopilot/Tools/setup_gazebo.bash ~/ros/firmware_ws/src/PX4-Autopilot ~/ros/firmware_ws/src/PX4-Autopilot/build/px4_sitl_default > /dev/null" >> ~/.bashrc
echo "export ROS_PACKAGE_PATH=\$ROS_PACKAGE_PATH:~/ros/firmware_ws/src/PX4-Autopilot" >> ~/.bashrc
echo "export ROS_PACKAGE_PATH=\$ROS_PACKAGE_PATH:~/ros/firmware_ws/src/PX4-Autopilot/Tools/sitl_gazebo" >> ~/.bashrc
