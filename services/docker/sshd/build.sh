#!/usr/bin/env bash

docker build \
    --build-arg SSH_PORT=$SSH_PORT \
    --build-arg WEB_IMAGE=$WEB_IMAGE \
    -t $SSHD_IMAGE \
    -f $DOCKER_SERVICES_DIR/sshd/Dockerfile .
