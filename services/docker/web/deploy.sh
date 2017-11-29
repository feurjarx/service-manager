#!/usr/bin/env bash

dir="$DOCKER_SERVICES_DIR/$SERVICE_NAME/"
sh $dir/build.sh
sh $dir/run.sh