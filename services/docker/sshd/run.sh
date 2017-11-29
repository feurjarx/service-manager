#!/usr/bin/env bash

docker run -d -P \
    -p $SSH_PORT:22 \
    --cap-add=NET_ADMIN \
    -v //var/run/docker.sock:/var/run/docker.sock \
    --name $SSHD_CONTAINER $SSHD_IMAGE

# -v //var/run/docker.sock:/var/run/docker.sock \ it's for "docker-in-docker" implementation