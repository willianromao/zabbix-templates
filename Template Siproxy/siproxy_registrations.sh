#!/bin/sh
# /usr/local/etc/zabbix3/zabbix/externalscripts/siproxy_registrations.sh

i=`grep -i -w $1 /var/siproxd/siproxd_registrations`

if [ -n "$i" ] ; then
	echo 1
else
	echo 0
fi
