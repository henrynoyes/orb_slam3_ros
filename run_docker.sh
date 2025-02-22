#!/bin/bash

DISPLAY_NUMBER=$(echo $DISPLAY | cut -d. -f1 | cut -d: -f2)

xhost +local:docker

docker run -it \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="/media:/media:ro" \
    --volume="$(pwd)/data:/data" \
    --network=host \
    --privileged \
    --name ros_noetic \
    --rm \
    orbslam3_ros1

xhost -local:docker