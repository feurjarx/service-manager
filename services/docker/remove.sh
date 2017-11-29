#!/usr/bin/env bash

containerName=$($DOCKER_SERVICES_DIR/_detect-container.sh)
echo "Removing of $containerName ..."
docker rm $containerName