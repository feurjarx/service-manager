#!/usr/bin/env bash

sh $DOCKER_SERVICES_DIR/kill.sh
docker volume rm $MYSQL_VOLUME