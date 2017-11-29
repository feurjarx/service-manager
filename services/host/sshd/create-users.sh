#!/usr/bin/env bash

keysFile="authorized_keys"

IFS=","; for credentials in $SSH_USERS; do
    user="$(echo $credentials | cut -d'@' -f1)";
    pass="$(echo $credentials | cut -d'@' -f2)";
    useradd $user \
        --create-home \
        --password "$(openssl passwd -1 "$pass")" \
        --shell /bin/bash

    usermod -a -G root,$SSH_USERS_GROUP $user
    echo "created $user"

    sshDir="/home/$user/.ssh"
    mkdir $sshDir
    chmod 700 $sshDir
    cat $SSHD_PUBLIC_KEYS_DIR/$user.pub >> $sshDir/$keysFile
    chmod 600 $sshDir/$keysFile
    chown -R $user:$SSH_USERS_GROUP $sshDir
done
