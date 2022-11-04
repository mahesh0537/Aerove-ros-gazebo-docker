#!/bin/bash

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

echo "Running Docker Container"


sudo docker run \
  -it \
  --network host \
  --privileged \
  --gpus all \
  -p 14550:14550 \
  --volume=$XSOCK:$XSOCK:rw \
  --volume=$XAUTH:$XAUTH:rw \
  --env="XAUTHORITY=${XAUTH}" \
  --env DISPLAY=$DISPLAY \
  --env TERM=xterm-256color \
  -v /dev/shm:/dev/shm \
  -v $(pwd):$(pwd) -w $(pwd)\
  ros2
