#!/bin/sh

IFACE=$(netstat -nr | grep -i default | awk '{print $4}' | head -n 1)

zabbix_get -s 172.16.4.1 -k net.if.out[$IFACE]
