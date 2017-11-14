#!/usr/bin/env bash

docker rm $MYSQL_CONTAINER_NAME -f
docker volume rm $MYSQL_DATA_NAME
