#!/bin/bash

PING=$(sudo /usr/local/sbin/fping $1 2> /dev/null | awk '{print $3}')

if [ "$PING" = "alive" ]
then
	echo 1
else
	echo 0
fi
