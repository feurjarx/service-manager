#!/usr/bin/env bash
## see: based on https://hub.docker.com/_/mysql/

function __checkContainerInProcesses {
    containerName=$1
    if docker ps -a --format "{{.Names}}" | grep $containerName;
    then
        echo "Error! Container $containerName already was launched."
        exit 1;
    fi
}

function __waitForDatabaseConnection {
    timeout=20
    count=0

    echo "Waiting for connection ..."

    passwordFragment=""
    if [ "$MYSQL_ALLOW_EMPTY_PASSWORD" != "true" ]; then
        passwordFragment="--password=$MYSQL_DB_PASS"
    fi

    while ! docker exec -t $MYSQL_CONTAINER mysql -u $MYSQL_USER -e "SELECT 1" $passwordFragment $MYSQL_DB &>/dev/null
    do
        counter=$[$counter+1]
        sleep 1
        if [ $counter -gt $timeout ]; then
            echo "[x] Error! There is not connection."
            exit 1
        fi
    done

    echo "Done."
}

function __runMysqlContainer {
    __checkContainerInProcesses $MYSQL_CONTAINER

    echo "Creating of volume for mysql-data:"
    docker volume create $MYSQL_VOLUME

    echo "Running of mysql container..."

    if [ "$MYSQL_ALLOW_EMPTY_PASSWORD" = "true" ]; then
        echo "[!] Warning! Empty password is allowed for mysql."
        cmd="docker run -d -p $MYSQL_PORT:3306 \
                -e MYSQL_ALLOW_EMPTY_PASSWORD=$MYSQL_ALLOW_EMPTY_PASSWORD \
                -e MYSQL_DATABASE=$MYSQL_DB \
                -v $MYSQL_VOLUME:/var/lib/mysql \
                --name $MYSQL_CONTAINER mysql"
    else
        cmd="docker run -d -p $MYSQL_PORT:3306 \
                -e MYSQL_ROOT_PASSWORD=$MYSQL_DB_PASS \
                -e MYSQL_DATABASE=$MYSQL_DB \
                -v $MYSQL_VOLUME:/var/lib/mysql \
                --name $MYSQL_CONTAINER mysql"
    fi

    ## running from mysql image
    echo $cmd && ($cmd)

    returnedCode=$?
    if [ $returnedCode != 0 ]; then
        echo "[x] Error with running of container."
        exit 1
    fi
}

__runMysqlContainer
__waitForDatabaseConnection