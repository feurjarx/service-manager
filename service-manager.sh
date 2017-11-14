#!/usr/bin/env bash

set -a
if [ "$3" != "" ]; then . $3; else . .env; fi
set +a

function __usage ()
{
  echo "Usage : $0 <service-type> <action>"
  echo "ex.: $0 mysql deploy"
  exit
}

executer="./docker-services/$1/$2.sh"
if [ -f "$executer" ]
then
    echo sh $executer
    sh $executer
else
	echo "[x] Error! Command is not supported."
	__usage
fi
