#!/usr/bin/env bash

if [ "$DEV_MODE" = "true" ]; then
    echo "Development mode is enabled"
    docker run -d -it \
        -p $WEB_PORT:8000 \
        -e XDEBUG_CONFIG="remote_host=$HOST_IP" \
        --hostname $WEB_HOSTNAME \
        --link $MYSQL_CONTAINER:db \
        --name $WEB_CONTAINER $WEB_IMAGE
#        -e XDEBUG_CONFIG="remote_host=192.168.2.2" \
else
    docker run -d -it \
        -p $WEB_PORT:8000 \
        --link $MYSQL_CONTAINER:db \
        --name $WEB_CONTAINER $WEB_IMAGE
fi

#    -e PHP_IDE_CONFIG="serverName=admin.village" \