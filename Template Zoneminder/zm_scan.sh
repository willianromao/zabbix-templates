#!/bin/bash

MYSQLDB=zm
MYSQLUSER=zabbix
MYSQLPASS=Scrf@2015
MYSQLQUIERY="select id, name from Monitors where Enabled = '1' and Function = 'Modect';"

nlinhas=$( mysql -u$MYSQLUSER -p$MYSQLPASS $MYSQLDB -h 0 -e "$MYSQLQUIERY" | tail -n +2 | wc -l )
contador=1

echo '{"data":['

mysql -u$MYSQLUSER -p$MYSQLPASS $MYSQLDB -h 0 -e "$MYSQLQUIERY" | tail -n +2 | while read linha

do

	ID=$( echo $linha | awk '{print $1}' )
	NAME=$( echo $linha | awk '{$1=""; print $0}' | sed 's/^.//' )
	
		if [ $contador = $nlinhas ] ; then
				echo '{"{#ID}":"'$ID'","{#NAME}":"'$NAME'"}' 
		else
				echo '{"{#ID}":"'$ID'","{#NAME}":"'$NAME'"},' 
		fi
	
contador=$[$contador+1]

done

echo ']}'
