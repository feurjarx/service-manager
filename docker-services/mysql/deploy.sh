#!/usr/bin/env bash
# based on https://hub.docker.com/_/mysql/

function __checkContainerInProcesses {
    containerName=$1
    if docker ps -a --format "{{.Names}}" | grep $containerName;
    then
        echo "Error! Container $containerName already was launched."
        exit 1;
    fi
}

function __runMysqlContainer {
    __checkContainerInProcesses $MYSQL_CONTAINER_NAME

    echo "Creating of volume for mysql-data:"
    docker volume create $MYSQL_DATA_NAME

    echo "Running of mysql container."
    docker run -d -p $DB_PORT:3306 \
        -e MYSQL_ALLOW_EMPTY_PASSWORD=true \
        -v $MYSQL_DATA_NAME:/var/lib/mysql \
        --name $MYSQL_CONTAINER_NAME mysql &>/dev/null
    #-e MYSQL_ROOT_PASSWORD=$DB_PASS

    returnedCode=$?
    if [ $returnedCode != 0 ]; then
        echo "[x] Error with running of container."
        exit 1
    fi
}

function __waitForDatabaseConnection {
    timeout=20
    count=0
    echo "Waiting for connection ..."

#    while ! docker exec -t $MYSQL_CONTAINER_NAME mysql --user=$DB_USER --password=$DB_PASS mysql -e "SELECT 1" &>/dev/null
    while ! docker exec -t $MYSQL_CONTAINER_NAME mysql --user=$DB_USER mysql -e "SELECT 1" &>/dev/null
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


function __createDatabase {
    echo "Creating of db: $DB_NAME  ..."

#    docker exec -t $MYSQL_CONTAINER_NAME mysql --user=$DB_USER --password=$DB_PASS -e "CREATE DATABASE $DB_NAME" &>/dev/null
    docker exec -t $MYSQL_CONTAINER_NAME \
        mysql --user=$DB_USER -e "CREATE DATABASE $DB_NAME" &>/dev/null

    returnedCode=$?
    if [ $returnedCode == 0 ];
    then
        echo "Done."
    else
        echo "[x] Error during db creating. (code: $returnedCode)"
        exit $returnedCode;
    fi
}

function __executeMigrations {
    echo "Initialization of backend ..."
    # ...
}

__runMysqlContainer
__waitForDatabaseConnection
__createDatabase
__executeMigrations
# ... app actions for example, npm i etc.

exit 0
