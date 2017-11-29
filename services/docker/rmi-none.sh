#!/usr/bin/env bash

docker rmi $(docker images --filter "dangling=true" -q --no-trunc) 2>/dev/null