#!/bin/bash

HOJE=$( date '+%Y-%m-%d' )
ONTEM=$( date '+%Y-%m-%d' -d "1 day ago" )

PASS=$(sudo awk '{ if ( $1 >= "'[$ONTEM'" && $1 < "'[$HOJE'" ) print }' /var/log/asterisk/full | grep "Wrong password")

if [[ -n "$PASS" ]];
   then echo "0"
    else echo "1"
fi

