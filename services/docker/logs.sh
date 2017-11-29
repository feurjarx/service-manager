#!/usr/bin/env bash

containerName=$($DOCKER_SERVICES_DIR/_detect-container.sh)
echo "Getting of logs from $containerName ..."
docker logs $containerName