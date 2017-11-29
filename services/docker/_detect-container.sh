#!/usr/bin/env bash

serviceName=$(echo $SERVICE_NAME | tr /a-z/ /A-Z/)
eval "containerName=\$$( echo $serviceName"_CONTAINER" )"
echo $containerName