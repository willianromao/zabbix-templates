#!/usr/local/bin/bash
# cron */1 * * * *	root /root/scripts/ipsec_reload.sh
TUNNEL=`grep -i tunnel /root/scripts/ipsec_scan.sh | cut -d, -f2 | cut -d'"' -f4`
DESTIP=`grep -i tunnel /root/scripts/ipsec_scan.sh | cut -d, -f3 | cut -d'"' -f4`
SOURCEIP=`grep -i tunnel /root/scripts/ipsec_scan.sh | cut -d, -f4 | cut -d'"' -f4`
STATUS=`/root/scripts/ipsec.sh $TUNNEL`
PING=`/root/scripts/ipsec.sh $DESTIP $SOURCEIP`

if [ "$STATUS" -eq "0" ] ; then

	/usr/local/sbin/pfSsh.php playback svc stop ipsec
	sleep 15
	/usr/local/sbin/pfSsh.php playback svc start ipsec

else

		if [ "$PING" -eq "0" ] ; then

			/usr/local/sbin/pfSsh.php playback svc stop ipsec
			sleep 15
			/usr/local/sbin/pfSsh.php playback svc start ipsec
		
		fi
		
fi
