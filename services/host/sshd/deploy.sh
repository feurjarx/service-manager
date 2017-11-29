#!/usr/bin/env bash

function __setupSshd {
    apt-get update && apt-get install -y \
        openssh-server \
        openssl

    ## Base preparing of sshd
    if [ ! -f /var/run/sshd ]; then
        mkdir /var/run/sshd
    fi

    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
    echo "export VISIBLE=now" >> /etc/profile
}

function __setUserRules {
    chown -R admin:$SSH_USERS_GROUP $SERVICE_MANAGER_DIR
    # other assignments ...
    IFS=","; for credentials in $SSH_USERS; do
        user="$(echo $credentials | cut -d'@' -f1)";
        # ...
    done
}

function __createSshGroup {
    if [ ! `grep -q $SSH_USERS_GROUP /etc/group` ]; then
        groupadd $SSH_USERS_GROUP
        echo "created group $SSH_USERS_GROUP."
    fi
    if [ "$SSHD_PERMIT_ROOT_LOGIN" == "yes" ]; then
        echo "[!] Warning! PermitRootLogin has value is yes"
        usermod -a -G root,$SSH_USERS_GROUP root
    fi
}

function __chageRootPassword {
    if [ "$SSHD_ROOT_PASSWORD" != "" ]; then
        echo "root:$SSHD_ROOT_PASSWORD" | chpasswd
        echo "[!] Warning! Root password was changed."
    fi
}

chmod +x -R $SERVICE_MANAGER_DIR
## Converting of files
find $SERVICE_MANAGER_DIR/ -name '*.sh' |xargs dos2unix
find $SERVICE_MANAGER_DIR/ -name '.env' |xargs dos2unix
find $SERVICE_MANAGER_DIR -name "*.sh" | xargs sed -i "s/^sh /.\//g"

cd $SERVICE_MANAGER_DIR

__chageRootPassword

__setupSshd

## Apply sshd_config
sh service.sh host sshd update-sshd_config

__createSshGroup

sh service.sh host sshd create-users

## Set assignments of rights for users
__setUserRules

sh service.sh host docker install