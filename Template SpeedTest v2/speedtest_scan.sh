#!/bin/sh

IFACE=$(netstat -nr | grep -i default | awk '{print $4}')

# em0 = VIVO
if [ "$IFACE" = "em0" ] ; then

echo '{"data":['
echo '{"{#LINK}":"de internet", "{#CLIENTE}":"Domuspopuli", "{#ALARM_UP}":"50", "{#ALARM_DOWN}":"160"}'
echo ']}'

# NET
else

echo '{"data":['
echo '{"{#LINK}":"de internet", "{#CLIENTE}":"Domuspopuli", "{#ALARM_UP}":"8", "{#ALARM_DOWN}":"48"}'
echo ']}'

fi
