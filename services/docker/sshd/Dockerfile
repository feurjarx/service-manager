FROM debian:latest

ARG SSH_PORT=22
ARG WEB_IMAGE

RUN apt-get update && apt-get install -y \
    dos2unix nano

## Copy files of service manager, provide the access and some converting
ENV serviceManagerDir /service-manager
RUN mkdir ${serviceManagerDir}

COPY ./services ${serviceManagerDir}/services
ADD ./service.sh ${serviceManagerDir}/service.sh
COPY .env ${serviceManagerDir}/.env
COPY ./docker-compose.prod.yml ${serviceManagerDir}/docker-compose.prod.yml
COPY ./docker-compose.dev.yml ${serviceManagerDir}/docker-compose.dev.yml
COPY ./${WEB_IMAGE}.tar ${serviceManagerDir}/${WEB_IMAGE}.tar

## Converting of files
RUN find ${SERVICE_MANAGER_DIR}/ -name '*.sh' |xargs dos2unix
RUN find ${SERVICE_MANAGER_DIR}/ -name '.env' |xargs dos2unix
RUN find ${SERVICE_MANAGER_DIR} -name "*.sh" | xargs sed -i "s/^sh /.\//g"

## Executing of deploy
RUN cd ${serviceManagerDir}; \
    ./service.sh host sshd deploy

EXPOSE ${SSH_PORT}

ENV sshLogDir /var/log/sshd
RUN mkdir ${sshLogDir} && echo "" > ${sshLogDir}/access.log

CMD cd ${serviceManagerDir}; \
    ./service.sh host sshd init & /usr/sbin/sshd -D -E  ${sshLogDir}/access.log
#CMD ["/usr/sbin/sshd", "-D"]