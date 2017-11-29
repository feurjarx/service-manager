#!/usr/bin/env bash

containerName=$($DOCKER_SERVICES_DIR/_detect-container.sh)

docker ps | grep $containerName &>/dev/null
returnedCode=$?
if [ $returnedCode != 0 ]; then
    echo "container's name: $containerName"
    echo "[x] Error! Incorrect service, missing or not defined variable (format: <service_name>_CONTAINER_NAME=...)"
    echo "error code $returnedCode."
    exit 1;
fi

echo "Connecting to $containerName ..."
docker exec -i -t $containerName bash
