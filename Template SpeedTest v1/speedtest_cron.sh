#!/bin/sh
# */1 * * * *	root	/root/scripts/speedtest_cron.sh

INTERFACES=$(grep -i cron /root/scripts/speedtest_scan.sh | sed 's/# cron //gi')

for int in `echo $INTERFACES`
do
/root/scripts/speedtest.sh $int
done
