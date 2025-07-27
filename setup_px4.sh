#!/bin/bash

# Update and install core tools
sudo apt update && sudo apt upgrade -y
sudo apt install -y git python3-pip python3-jinja2 build-essential wget cmake ninja-build exiftool x11-apps

# Clone PX4-Autopilot
cd ~
git clone https://github.com/PX4/PX4-Autopilot.git --recursive
cd PX4-Autopilot

# Install PX4 dependencies
bash ./Tools/setup/ubuntu.sh

# Build SITL with Gazebo
make px4_sitl gazebo

# Install Python MAVSDK
pip3 install mavsdk

echo "✅ PX4, Gazebo, and MAVSDK installed!"
echo "You can now run: make px4_sitl gazebo"
