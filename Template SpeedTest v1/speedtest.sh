# MULTI WAN

#!/bin/sh

IPv4=$(ifconfig $1 | grep -iw inet | awk '{print $2}')

/usr/local/bin/speedtest-cli --source $IPv4 > /tmp/speedtest_$1.tmp2

mv /tmp/speedtest_$1.tmp2  /tmp/speedtest_$1.tmp


# SINGLE WAN

#!/bin/sh

/usr/local/bin/speedtest-cli > /tmp/speedtest.tmp2

mv /tmp/speedtest.tmp2  /tmp/speedtest.tmp
