#!/usr/bin/env bash

docker run -d -it \
    --name $FAIL2BAN_CONTAINER \
    --net host \
    --privileged \
    $FAIL2BAN_IMAGE

# -v /var/log:/var/log \