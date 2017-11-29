#!/usr/bin/env bash

mode=$($SERVICES_DIR/_get-mode.sh)
docker-compose -f ./docker-compose.$mode.yml down