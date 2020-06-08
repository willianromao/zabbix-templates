#!/bin/bash

ntrunks=$( sudo /usr/sbin/asterisk -rx 'sip show registry' | grep -i "sip registrations" | awk '{print $1}' )

get_trunks() {

ultimalinha=$[$ntrunks-1]
linha=2

echo '{"data":['

for ((trunk=0;$trunk<$ntrunks;trunk++))
do

        hostname=$( sudo /usr/sbin/asterisk -rx 'sip show registry' | head -$linha | tail -1 | awk '{print $1}' | cut -d: -f1 )
        username=$( sudo /usr/sbin/asterisk -rx 'sip show registry' | head -$linha | tail -1 | awk '{print $3}' )
        if [ $ultimalinha = $trunk ] ; then
                echo '{"{#HOSTNAME}":"'$hostname'", "{#USERNAME}":"'$username'"}'
        else
                echo '{"{#HOSTNAME}":"'$hostname'", "{#USERNAME}":"'$username'"},'
        fi
        linha=$[$linha+1]
done

echo ']}'

}

if [ $ntrunks -ge '0' ] ; then
        get_trunks
else
        echo ZBX_NOTSUPPORTED
fi
