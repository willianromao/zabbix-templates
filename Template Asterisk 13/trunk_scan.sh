#!/bin/bash

ntrunks=$( sudo /usr/sbin/asterisk -rx 'pjsip show registrations' | grep -i "Objects found:" | awk '{print $3}' )

get_trunks() {

ultimalinha=$[$ntrunks-1]
linha=5

echo '{"data":['

for ((trunk=0;$trunk<$ntrunks;trunk++))
do

        username=$( sudo /usr/sbin/asterisk -rx 'pjsip show registrations' | head -$linha | tail -1 | awk '{print $1}' | cut -d/ -f1 )
        hostname=$( sudo /usr/sbin/asterisk -rx 'pjsip show registrations' | head -$linha | tail -1 | awk '{print $1}' | cut -d: -f2 )
        if [ $ultimalinha = $trunk ] ; then
                echo '{"{#HOSTNAME}":"'$hostname'", "{#USERNAME}":"'$username'"}'
        else
                echo '{"{#HOSTNAME}":"'$hostname'", "{#USERNAME}":"'$username'"},'
        fi
        linha=$[$linha+1]
done

echo ']}'

}

if [ $ntrunks -gt '0' ] 2> /dev/null ; then
        get_trunks
else
        echo ZBX_NOTSUPPORTED
fi