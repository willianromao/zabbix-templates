#!/bin/bash

nramais=$( sudo /usr/sbin/asterisk -rx 'pjsip list identifies' | grep -iv "Endpoint" | cut -d: -f2 | grep -i identify | wc -l )

get_ramais() {

linha=1

sudo /usr/sbin/asterisk -rx 'pjsip list identifies' | grep -iv "Endpoint" | cut -d: -f2 | grep -i identify | cut -d/ -f2 | while read ramal
do



		host=$( sudo /usr/sbin/asterisk -rx "pjsip show endpoint $ramal" | grep -iw "Contact:  $ramal" | awk '{print $2}' | cut -d@ -f2 | cut -d: -f1 )
		callerid=$( sudo /usr/sbin/asterisk -rx "pjsip show endpoint $ramal" | grep -iw Callerid | cut -d: -f2 | sed 's/"//' | sed 's/"//' | sed 's/ //' )
			
		if [ $nramais = $linha ] ; then
				echo '{"{#USERNAME}":"'$ramal'", "{#HOST}":"'$host'", "{#CALLERID}":"'$callerid'"}'
		else
				echo '{"{#USERNAME}":"'$ramal'", "{#HOST}":"'$host'", "{#CALLERID}":"'$callerid'"},'
		fi
	
		
	
	linha=$[$linha+1]
	
done

}
	
if [ $nramais -ge '0' ] ; then
		echo '{"data":[' 
		get_ramais
		echo ']}'

else
		echo ZBX_NOTSUPPORTED
fi
