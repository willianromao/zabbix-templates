#!/bin/bash

showpeers=/tmp/showpeers.tmp
linhas=/tmp/linhas.tmp
rm $linhas $showpeers &> /dev/null
sudo /usr/sbin/asterisk -rx 'sip show peers' | grep -ive "unmonitored" -e "Description" > /tmp/showpeers.tmp
nramais=$( wc -l $showpeers | awk '{print $1}' )

get_ramais() {

ultimalinha=$[$nramais-1]
linha=1

for ((ramal=0;$ramal<$nramais;ramal++))
do

        username=$( cat $showpeers | head -$linha | tail -1 | awk '{print $1}' | cut -d/ -f1 )
        host=$( cat $showpeers | head -$linha | tail -1 | awk '{print $2}' | sed 's/(//' | sed 's/)//' )
        callerid=$( sudo /usr/sbin/asterisk -rx "sip show peer $username" | grep -i Callerid | cut -d: -f2 | sed 's/"//' | sed 's/"//' )

                if [ $ultimalinha = $ramal ] ; then
                                resultado=$(echo '{"{#USERNAME}":"'$username'", "{#HOST}":"'$host'", "{#CALLERID}":"'$callerid'"}' >> $linhas)
                else
                                resultado=$(echo '{"{#USERNAME}":"'$username'", "{#HOST}":"'$host'", "{#CALLERID}":"'$callerid'"},' >> $linhas)
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
