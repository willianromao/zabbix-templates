#!/bin/bash

MYSQLDB=zm
MYSQLUSER=zabbix
MYSQLPASS=Scrf@2015
MYSQLQUIERY="select Id from Events WHERE MonitorId = '$1' order by Id desc limit 1 ;"

EVENTO=`mysql -u$MYSQLUSER -p$MYSQLPASS $MYSQLDB -h 0 -e "$MYSQLQUIERY" | tail -n +2`

if [ -z $EVENTO ] ; then
echo 0
else
echo $EVENTO
fi
