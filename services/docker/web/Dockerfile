FROM php:7.0

ARG DEV_MODE
ARG HOST_IP
ARG WEB_XDEBUG_PORT
ARG WEB_INIT_ANSWERS
ARG WEB_APP_DIR="/app"
ARG GIT_CREDENTIALS

## Extensions for working of yii application
RUN docker-php-ext-install mysqli pdo pdo_mysql

## Install secondary package
RUN apt-get update && apt-get install -y \
    dos2unix \
    nano \
    git

## Adding scripts, turning their into unix files and preparing
ENV webScriptsDir ./services/docker/web/scripts
ENV webInstallDir /web_install

RUN mkdir ${webInstallDir}

ADD ${webScriptsDir}/setup_xdebug.sh ${webInstallDir}/setup_xdebug
ADD ${webScriptsDir}/yii-init.sh ${webInstallDir}/yii-init
ADD ${webScriptsDir}/yii-migrate.sh ${webInstallDir}/yii-migrate

RUN find ${webInstallDir}/ -name '*' |xargs dos2unix
RUN chmod +x -R ${webInstallDir}/

RUN mv ${webInstallDir}/setup_xdebug / ; \
    mv ${webInstallDir}/yii-init / ; \
    mv ${webInstallDir}/yii-migrate / ;

## Setup xdebug when dev mode
RUN export WEB_XDEBUG_PORT=${WEB_XDEBUG_PORT}; \
    if [ "${DEV_MODE}" = "true" ]; then /setup_xdebug; fi

## Putting source
COPY . ${WEB_APP_DIR}
#RUN git clone -b "feature/VAB-323_prod_server_preparation" \
#    "http://${GIT_CREDENTIALS}@gitlab.icerockdev.com/village-app/village-app-backend.git" ${WEB_APP_DIR}

RUN ls ${WEB_APP_DIR}

## Composer install
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin && \
    ln -s /usr/local/bin/composer.phar /usr/local/bin/composer

## Configuration of the connection to db and init yii application
RUN export WEB_APP_DIR="${WEB_APP_DIR}"; \
    export DEV_MODE="${DEV_MODE}"; \
    export WEB_INIT_ANSWERS="${WEB_INIT_ANSWERS}"; \
    /yii-init

ENV WEB_APP_DIR ${WEB_APP_DIR}
ENV HOST_IP ${HOST_IP}
CMD export WEB_APP_DIR="${WEB_APP_DIR}"; \
    export HOST_IP=${HOST_IP}; \
    /yii-migrate; \
    php -S 0.0.0.0:8000 -t ${WEB_APP_DIR}/backend/web
