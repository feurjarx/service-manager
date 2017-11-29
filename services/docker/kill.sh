#!/usr/bin/env bash

containerName=$($DOCKER_SERVICES_DIR/_detect-container.sh)
echo "Killing of $containerName ..."
docker rm $containerName -f