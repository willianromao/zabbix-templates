#!/bin/bash


    status=`zmdc.pl check | grep -i running`

        if [ -z $status ] ; then

        echo 0

        else

        echo 1

        fi
