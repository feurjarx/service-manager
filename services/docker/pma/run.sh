#!/usr/bin/env bash
# based on https://hub.docker.com/r/phpmyadmin/phpmyadmin/

docker run -d -p $PMA_PORT:80 \
    --name $PMA_CONTAINER \
    --link $MYSQL_CONTAINER:db \
    -e MYSQL_USER=$MYSQL_USER \
    phpmyadmin/phpmyadmin
#    -e MYSQL_ROOT_PASSWORD=$MYSQL_DB_PASS \