#!/usr/bin/env bash

containerName=$($DOCKER_SERVICES_DIR/_detect-container.sh)
echo "Starting of $containerName ..."
docker start $containerName