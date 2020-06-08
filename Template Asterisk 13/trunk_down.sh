#!/bin/bash

PATH="$(env |grep "^PATH" |cut -f2 -d"=")"

TRUNK=$(sudo /usr/sbin/asterisk -rx "sip show peers" | grep UNREACHABLE | awk '{print$1}'| grep [A-Za-z])

if [ -n "$TRUNK" ]
then
	echo $TRUNK
else
	echo "1"
fi





