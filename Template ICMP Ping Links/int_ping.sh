#!/bin/sh

if [ "$1" = "0.0.0.0" ]
then
        echo 0
else
        PING=$(fping --src=$1 $2 2> /dev/null | awk '{print $3}')

        if [ "$PING" = "alive" ]
        then
                echo 1
        else
                echo 0
        fi

fi
