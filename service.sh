#!/usr/bin/env bash

set -a
if [ "$4" != "" ]; then . $4; else . ./.env; fi
SERVICES_DIR="./services"
DOCKER_SERVICES_DIR="$SERVICES_DIR/docker"
HOST_SERVICES_DIR="$SERVICES_DIR/host"
SERVICE_TYPE=$1
SERVICE_NAME=$2
SERVICE_ACTION=$3
set +a

function __usage ()
{
  echo "Usage : $0 <service-type> <service-name> <action>"
  echo "ex.: $0 docker web deploy"
  exit
}

executer="$SERVICES_DIR/$SERVICE_TYPE/$SERVICE_NAME/$SERVICE_ACTION.sh"
if [ ! -f "$executer" ]; then
    executer="$SERVICES_DIR/$SERVICE_TYPE/$SERVICE_ACTION.sh"
    if [ ! -f "$executer" ]
    then
        echo "[x] Error! Command is not supported."
        __usage
        exit 1
    fi
fi

echo sh $executer
sh $executer