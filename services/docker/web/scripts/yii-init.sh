#!/usr/bin/env bash

cd $WEB_APP_DIR

## Composer install
#if [ "$DEV_MODE" != "true" ]; then
#    composer global require "fxp/composer-asset-plugin:^1.2.0"
#    composer config --global github-oauth.github.com "2ea18ae487291582965a30b22ff09020f2f37407"
#    rm composer.lock;
#    composer install --no-interaction;

    ## Initialization of yii application
    autoinput=$( echo $WEB_INIT_ANSWERS | sed 's/ /\\n/g' );
    echo -e $autoinput | php init;
#fi

