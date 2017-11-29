#!/usr/bin/env bash

mode="dev"
if [ "$DEV_MODE" != "true" ]; then
     mode="prod"
fi

echo $mode