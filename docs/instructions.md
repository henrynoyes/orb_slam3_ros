
```
docker build -t orbslam3_ros1 .
```

```
cd data && wget http://robotics.ethz.ch/~asl-datasets/ijrr_euroc_mav_dataset/vicon_room1/V1_02_medium/V1_02_medium.bag
```

### term1
```
./run_docker
```

```
roslaunch orb_slam3_ros euroc_stereo_inertial.launch
```

### term2
```
docker exec -it ros_noetic bash
```

```
rosbag play /data/V1_02_medium.bag
```