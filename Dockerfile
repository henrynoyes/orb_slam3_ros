FROM amd64/ros:noetic-perception-focal

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        software-properties-common \
        git \
        nano \
        build-essential \
        cmake \
        g++ \
        ros-noetic-hector-trajectory-server \
        python3-catkin-tools

RUN apt-get install -y --no-install-recommends \
    libeigen3-dev \
    libepoxy-dev \
    libopencv-dev \
    libopenexr-dev \
    libgl1-mesa-dev \
    libwayland-dev \
    libxkbcommon-dev \
    wayland-protocols \
    libc++-dev \
    libglew-dev \
    ninja-build

RUN rm -rf /var/lib/apt/lists/* && apt-get clean

WORKDIR /root

RUN git clone https://github.com/stevenlovegrove/Pangolin.git -b v0.9 && \
    cd Pangolin && \
    cmake -B build && \
    cmake --build build

RUN mkdir -p catkin_ws/src && \
    cd catkin_ws/src && \
    git clone https://github.com/henrynoyes/orb_slam3_ros.git && \
    git clone https://github.com/ros-perception/vision_opencv.git -b noetic && \
    cd .. && \
    catkin config \
    --extend /opt/ros/noetic && \
    catkin build || true && \
    catkin build

RUN echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc