#!/usr/bin/env bash

docker build \
    --build-arg HOST_IP=$HOST_IP \
    --build-arg WEB_INIT_ANSWERS="$WEB_INIT_ANSWERS" \
    --build-arg WEB_XDEBUG_PORT=$WEB_XDEBUG_PORT \
    --build-arg DEV_MODE=$DEV_MODE \
    --build-arg GIT_CREDENTIALS=$GIT_CREDENTIALS \
    -t $WEB_IMAGE \
    -f $DOCKER_SERVICES_DIR/web/Dockerfile .

# --build-arg WEB_APP_DIR="$WEB_APP_DIR" \