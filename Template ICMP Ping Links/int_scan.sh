DMZ e IP Fixo

#!/bin/sh
echo '{"data":['
echo '{"{#LINK}":"VIVO", "{#INT_IP}":"192.168.15.2", "{#SERV_PING}":"208.67.222.222"},'
echo '{"{#LINK}":"NET", "{#INT_IP}":"192.168.0.2", "{#SERV_PING}":"208.67.220.220"}'
echo ']}'

BRIDGE DDNS

#!/bin/sh

LINK1=pppoe0
LINK2=em1

IP1=$(ifmcstat -i $LINK1 | grep -w inet | awk '{print $2}')
IP2=$(ifmcstat -i $LINK2 | grep -w inet | awk '{print $2}')

if [ -z $IP1 ] ; then
IP1=0.0.0.0
fi

if [ -z $IP2 ] ; then
IP2=0.0.0.0
fi

echo '{"data":['
echo '{"{#LINK}":"VIVO", "{#INT_IP}":"'$IP1'", "{#SERV_PING}":"208.67.222.222"},'
echo '{"{#LINK}":"NET", "{#INT_IP}":"'$IP2'", "{#SERV_PING}":"208.67.220.220"}'
echo ']}'
