#!/usr/bin/env bash

docker save $WEB_IMAGE > ./$WEB_IMAGE.tar

if [ $? != 0 ]; then
     echo "Error code: $?"
     exit $?
fi

echo "Image $WEB_IMAGE was saved as $WEB_IMAGE.tar successfully."
