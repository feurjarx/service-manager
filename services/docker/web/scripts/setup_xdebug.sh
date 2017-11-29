#!/usr/bin/env bash

apt-get update && apt-get install -y \
    wget

xdebugZip="xdebug-2.5.5"
wget -O /$xdebugZip.tgz http://xdebug.org/files/$xdebugZip.tgz
tar -xvzf /$xdebugZip.tgz
cd /$xdebugZip && \
    phpize && \
    ./configure && \
    make

phpConfig="/usr/local/etc/php/php.ini"
remoteHostIp=$( /sbin/ip route|awk '/default/ { print $3 }' )

cat << EOF > $phpConfig
zend_extension=/$xdebugZip/modules/xdebug.so
xdebug.remote_autostart=1
xdebug.remote_enable=1
xdebug.remote_handler=dbgp
xdebug.remote_connect_back=0
xdebug.remote_host=$remoteHostIp
xdebug.remote_port=$WEB_XDEBUG_PORT
xdebug.remote_mode=req
xdebug.idekey=PHPSTORM
EOF

rm /$xdebugZip.tgz
