#!/usr/bin/env bash

# todo: auto creating of compose yml file by .env depends on $DEV_MODE (?)
#cat << EOF > $dir/docker-compose.yml
#version: '2'
#services:
#  web:
#      container_name: village.web
#      build:
#        dockerfile: ./services/docker/web/Dockerfile
#        args:
#          DEV_MODE: 0
#          HOST_IP: 10.0.75.1
#          WEB_INIT_ANSWERS: "0 yes Yes Yes"
#          WEB_APP_DIR: "/app"
#          GIT_CREDENTIALS: "deployer:r8gl9XY4oMCX"
#      ports:
#          - "80:8000"
#      links:
#          - db
#  db:
#      container_name: village.db
#      image: mysql
#      volumes:
#          - mydata:/var/lib/mysql
#      environment:
#          MYSQL_USER: root
#          MYSQL_DATABASE: village
#          # todo: to add password
#          MYSQL_ALLOW_EMPTY_PASSWORD: "true"
#EOF

mode=$($SERVICES_DIR/_get-mode.sh)
echo "Mode: $mode"
docker-compose -f ./docker-compose.$mode.yml up
