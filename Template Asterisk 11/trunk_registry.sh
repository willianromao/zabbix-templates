#!/bin/bash

REGISTRO=$(sudo /usr/sbin/asterisk -rx "sip show registry" | grep $1 | grep $2 | awk '{print $5}')

if [ "$REGISTRO" = "Registered" ]
then
	echo 1
else
	echo 0
fi
