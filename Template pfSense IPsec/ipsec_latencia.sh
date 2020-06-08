#!/usr/local/bin/bash


    rtt=`fping -r 1 -e -S $2 $1 | grep alive | awk '{print $4}' | sed 's/(//g'`

        if [ -z $rtt ] ; then

        echo 0

        else

        echo $rtt

        fi

