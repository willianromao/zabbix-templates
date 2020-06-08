#!/bin/bash

check=$(sudo /usr/sbin/asterisk -rx 'core show uptime' | awk -F": " '/Last reload/{print$2}')


if [ -z "$check" ]
then
	echo "Asterisk has not been reloaded yet"
else
	echo "$check"
fi
