#!/bin/bash

REGISTRO=$(sudo /usr/sbin/asterisk -rx "pjsip show registrations" | grep $1 | grep $2 | awk '{print $3}')

if [ "$REGISTRO" = "Registered" ]
then
	echo 1
else
	echo 0
fi
