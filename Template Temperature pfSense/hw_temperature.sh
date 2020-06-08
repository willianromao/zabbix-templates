#!/bin/sh
i=`sysctl hw.acpi.thermal.tz0.temperature 2> /dev/null | awk '{print $2}' | sed 's/C//g'`
if [ -n "$i" ] ; then
echo $i
else
echo ZBX_NOTSUPPORTED
fi