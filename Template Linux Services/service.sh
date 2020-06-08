#!/bin/bash
SERVICE=$(sudo systemctl status $1 | grep -oi running)
if [ "$SERVICE" = "running" ]
then
	echo 1
else
	echo 0
fi
