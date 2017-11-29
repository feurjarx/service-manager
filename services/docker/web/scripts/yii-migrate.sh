#!/usr/bin/env bash

cd $WEB_APP_DIR

## Support connection to db
sed -i "s/localhost/$HOST_IP/g" ./common/config/main.php
sed -i "s/localhost/$HOST_IP/g" ./common/config/main-local.php

echo "yes" | php yii migrate;
echo "yes" | php yii migrate/up --migrationPath=@yii/rbac/migrations;
php yii role/init
