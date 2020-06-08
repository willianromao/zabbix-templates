#!/bin/bash

showpeers=/tmp/iaxshowpeers.tmp
linhas=/tmp/iaxlinhas.tmp
rm $linhas $showpeers &> /dev/null
sudo /usr/sbin/asterisk -rx 'iax2 show peers' | grep -ive "unmonitored" -e "Description" > $showpeers
nramais=$( wc -l $showpeers | awk '{print $1}' )

get_ramais() {

ultimalinha=$[$nramais-1]
linha=1

for ((ramal=0;$ramal<$nramais;ramal++))
do
		
	username=$( cat $showpeers | head -$linha | tail -1 | awk '{print $1}' | cut -d/ -f1 )
	callerid=$( sudo /usr/sbin/asterisk -rx "iax2 show peer $username" | grep -i Callerid | cut -d: -f2 | sed 's/ "//' | sed 's/"//' )
		
		if [ $ultimalinha = $ramal ] ; then
				resultado=$(echo '{"{#USERNAME}":"'$username'", "{#CALLERID}":"'$callerid'"}' >> $linhas)
		else
				resultado=$(echo '{"{#USERNAME}":"'$username'", "{#CALLERID}":"'$callerid'"},' >> $linhas)
		fi
	linha=$[$linha+1]
	
done

}

if [ $nramais -ge '0' ] ; then
		echo '{"data":[' >> $linhas
		get_ramais
		echo ']}' >> $linhas
		cat $linhas

else
		echo ZBX_NOTSUPPORTED
fi

