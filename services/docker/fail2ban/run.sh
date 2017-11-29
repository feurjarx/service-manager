#!/usr/bin/env bash

docker run -d -it \
    --name $FAIL2BAN_CONTAINER \
    -v /var/log:/var/log \
    --net host \
    --privileged \
    $FAIL2BAN_IMAGE