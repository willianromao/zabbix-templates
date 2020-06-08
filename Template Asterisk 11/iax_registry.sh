#!/bin/bash

REGISTRO=$(sudo /usr/sbin/asterisk -rx "iax2 show peer $1" | grep Status | awk '{print $3}')

if [ "$REGISTRO" = "OK" ]
then
        echo 1
else
        echo 0
fi
