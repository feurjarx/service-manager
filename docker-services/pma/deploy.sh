#!/usr/bin/env bash
# based on https://hub.docker.com/r/phpmyadmin/phpmyadmin/

docker run -d -p $PMA_PORT:80 \
    --name $PMA_CONTAINER_NAME \
    --link $MYSQL_CONTAINER_NAME:db \
    -e MYSQL_ROOT_PASSWORD=$DB_PASS \
    -e MYSQL_USER=$root \
    phpmyadmin/phpmyadmin

returnedCode=$?
if [ $returnedCode != 0 ]; then
    echo "[x] Error with running of container."
    exit 1
fi
