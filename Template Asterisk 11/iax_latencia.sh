#!/bin/bash

LATENCIA=$(sudo /usr/sbin/asterisk -rx "iax2 show peer $1" | grep Status | awk '{print $4}' | cut -d'(' -f2)

if [ -z $LATENCIA ]
then

echo 0

else

echo $LATENCIA

fi
