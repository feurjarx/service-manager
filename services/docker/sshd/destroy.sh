#!/usr/bin/env bash

containerName=$($DOCKER_SERVICES_DIR/_detect-container.sh)
docker rm $containerName -f
docker rmi $SSHD_IMAGE -f
