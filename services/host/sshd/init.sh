#!/usr/bin/env bash

function __removeExistedWebImage {
    imageId=$(docker images $WEB_IMAGE --format "{{.ID}}")
    if [ "$imageId" != "" ]; then
        echo "Image $WEB_IMAGE found (id=$imageId)"
        docker rmi $imageId
    fi
}


cd $SERVICE_MANAGER_DIR
sh service.sh host iptables setup

## run docker containers

sh service.sh docker fail2ban run

## preparing and running from web image
__removeExistedWebImage
echo "Loading image $WEB_IMAGE from file ..."
docker load < ./$WEB_IMAGE.tar
echo "Running from $WEB_IMAGE"
sh service.sh docker web up

