#!/bin/bash

# TODO: use .env to set user correctly

mcpid=$(pgrep -l -u mctown | grep java | awk '{ print $1 }')

if ! [ -z "$mcpid" ]
then
	while [ -e "/proc/$mcpid" ]; do sleep 1; done
fi
