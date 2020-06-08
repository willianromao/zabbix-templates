#!/usr/local/bin/bash
# /usr/local/etc/zabbix3/zabbix/externalscripts

MYSQLDB=zm
MYSQLUSER=portal
MYSQLPASS=Scrf@2015
MYSQLHOST=172.16.4.251
MYSQLQUIERY="select Id from Events WHERE MonitorId = '$1' order by Id desc limit 1 ;"

EVENTO=`mysql -u$MYSQLUSER -p$MYSQLPASS $MYSQLDB -h $MYSQLHOST -q -e "$MYSQLQUIERY" 2> /dev/null | tail -n +2`

if [ -z $EVENTO ] ; then
echo 0
else
echo $EVENTO
fi
