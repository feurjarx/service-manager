#!/usr/bin/env bash

containerName=$($DOCKER_SERVICES_DIR/_detect-container.sh)
echo "Stopping of $containerName ..."
docker stop $containerName