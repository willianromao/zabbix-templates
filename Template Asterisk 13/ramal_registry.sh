#!/bin/bash

REGISTRO=$(sudo /usr/sbin/asterisk -rx "pjsip show contacts" | grep $1 | awk '{print $4}')

if [ "$REGISTRO" = "Avail" ]
then
        echo 1
else
        echo 0
fi
