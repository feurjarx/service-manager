#!/usr/bin/env bash

sshConfig="/etc/ssh/sshd_config"

## Overwrite current config sshd_config
echo yes | cp -rf $SSHD_CONFIG_EXAMPLE $sshConfig

sed -i "s/#Port 22/Port $SSH_PORT/" $sshConfig
sed -i "s/#LogLevel INFO/LogLevel $SSHD_LOG_LEVEL/" $sshConfig
sed -i "s/#PasswordAuthentication no/PasswordAuthentication $SSHD_PASS_AUTH/" $sshConfig
sed -i "s/#PermitRootLogin no/PermitRootLogin $SSHD_PERMIT_ROOT_LOGIN/" $sshConfig

echo "AllowGroups $SSH_USERS_GROUP" >> $sshConfig

echo "update successful."