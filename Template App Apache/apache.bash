#!/bin/bash
#/opt/zabbix/etc/zabbix_agentd.conf		UserParameter=apache[*],/opt/zabbix/externalscripts/apache.sh $1
#        <Location /server-status>
#                SetHandler server-status
#                Order deny,allow
#                Deny from all
#                Allow from 127.0.0.1 localhost portal.safecompliance.com.br 181.214.224.110
#        </Location>
#
host=localhost
resposta=0
tmp=/opt/zabbix/tmp/apache_status
tmp_auto=/opt/zabbix/tmp/apache_status_auto
pega_status=`wget --quiet -O $tmp http://$host/server-status`
pega_status_auto=`wget --quiet -O $tmp_auto http://$host/server-status?auto`
case $1 in
TotalAccesses)
$pega_status_auto
fgrep "Total Accesses:" $tmp_auto | awk '{print $3}'
resposta=$?;;
TotalKBytes)
$pega_status_auto
fgrep "Total kBytes:" $tmp_auto | awk '{print $3}'
resposta=$?;;
Uptime)
$pega_status_auto
fgrep "Uptime:" $tmp_auto | awk '{print $2}'
resposta=$?;;
ReqPerSec)
$pega_status_auto
fgrep "ReqPerSec:" $tmp_auto | awk '{print $2}'
resposta=$?;;
BytesPerSec)
$pega_status_auto
fgrep "BytesPerSec:" $tmp_auto | awk '{print $2}'
resposta=$?;;
BytesPerReq)
$pega_status_auto
fgrep "BytesPerReq:" $tmp_auto | awk '{print $2}'
resposta=$?;;
BusyWorkers)
$pega_status_auto
fgrep "BusyWorkers:" $tmp_auto | awk '{print $2}'
resposta=$?;;
IdleWorkers)
$pega_status_auto
fgrep "IdleWorkers:" $tmp_auto | awk '{print $2}'
resposta=$?;;
WaitingForConnection)
$pega_status_auto
fgrep "Scoreboard:" $tmp_auto | awk '{print $2}'| awk 'BEGIN { FS ="_" } ; { print NF-1 }'
resposta=$?;;
StartingUp)
$pega_status_auto
fgrep "Scoreboard:" $tmp_auto | awk '{print $2}'| awk 'BEGIN { FS ="S" } ; { print NF-1 }'
resposta=$?;;
ReadingRequest)
$pega_status_auto
fgrep "Scoreboard:" $tmp_auto| awk '{print $2}'| awk 'BEGIN { FS ="R" } ; { print NF-1 }'
resposta=$?;;
SendingReply)
$pega_status_auto
fgrep "Scoreboard:" $tmp_auto | awk '{print $2}'| awk 'BEGIN { FS ="W" } ; { print NF-1 }'
resposta=$?;;
KeepAlive)
$pega_status_auto
fgrep "Scoreboard:" $tmp_auto | awk '{print $2}'| awk 'BEGIN { FS ="K" } ; { print NF-1 }'
resposta=$?;;
DNSLookup)
$pega_status_auto
fgrep "Scoreboard:" $tmp_auto | awk '{print $2}'| awk 'BEGIN { FS ="D" } ; { print NF-1 }'
resposta=$?;;
ClosingConnection)
$pega_status_auto
fgrep "Scoreboard:" $tmp_auto | awk '{print $2}'| awk 'BEGIN { FS ="C" } ; { print NF-1 }'
resposta=$?;;
Logging)
$pega_status_auto
fgrep "Scoreboard:" $tmp_auto | awk '{print $2}'| awk 'BEGIN { FS ="L" } ; { print NF-1 }'
resposta=$?;;
GracefullyFinishing)
$pega_status_auto
fgrep "Scoreboard:" $tmp_auto | awk '{print $2}'| awk 'BEGIN { FS ="G" } ; { print NF-1 }'
resposta=$?;;
IdleCleanupOfWorker)
$pega_status_auto
fgrep "Scoreboard:" $tmp_auto | awk '{print $2}'| awk 'BEGIN { FS ="I" } ; { print NF-1 }'
resposta=$?;;
OpenSlotWithNoCurrentProcess)
$pega_status_auto
fgrep "Scoreboard:" $tmp_auto | awk '{print $2}'| awk 'BEGIN { FS ="." } ; { print NF-1 }'
resposta=$?;;
Version)
$pega_status
fgrep Version $tmp | awk '{print $3}' | awk -F "/" '{print $2}'
resposta=$?;;
*)
echo ZBX_NOTSUPPORTED
esac
if [ "$resposta" -ne 0 ]; then
echo ZBX_NOTSUPPORTED
fi
exit $resposta