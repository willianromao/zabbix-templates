#!/usr/local/bin/bash
# Written By Nicole, transformed to Zabbix by Andre Schild
# Any Comments or Questions please e-mail to andre@schild.ws
#
# Plugin Name: check_ipsec
# Version: 2.2
# Date: 2017/11/27 2.2 Removed test for gateway.txt file
# Date: 2016/11/01 2.1 Added support for ikev1 tunnels with strongswan
# Date: 2015/02/06 2.0 Added support for strongswan
#
#
# ------------Defining Variables------------
PROGNAME=`basename $0`
PROGPATH=`echo $0 | sed -e 's,[\\/][^\\/][^\\/]*$,,'`
REVISION=`echo '$Revision: 2.0 $' | sed -e 's/[^0-9.]//g'`
#STRONG=`$IPSECBIN --version |grep strongSwan | wc -l`
DOWN=""
# ---------- Change to your needs ----------
PLUGINPATH="/root"
IPSECBIN="/usr/local/sbin/ipsec"
FPINGBIN="/usr/local/sbin/fping"
# ping server in network on the other side of the tunnel
PINGIP=1		# ping yes or no (1/0)
USE_SUDO=0		# Run the ipsec command via sudo
SUDOBIN="/usr/bin/sudo"
# ------------------------------------------

if [ $USE_SUDO -eq 1 ];
then
    IPSECCMD="$SUDOBIN -- $IPSECBIN"
else
    IPSECCMD=$IPSECBIN
fi

# . $PROGPATH/utils.sh


# Testing availability of $IPSECBIN, $FPINGBIN 

if [ $# -eq 0 ];
then
   echo UNKNOWN - missing Arguments. Run check_ipsec --help
   exit $STATE_UNKNOWN
fi

test -e $IPSECBIN
if [ $? -ne 0 ];
then
	echo CRITICAL - $IPSECBIN not exist
	exit $STATE_CRITICAL
fi

if [ $PINGIP -eq 1 ]
then
	test -e $FPINGBIN
	if [ $? -ne 0 ];
	then
		echo CRITICAL - $FPINGBIN not exist
		exit $STATE_CRITICAL
	fi
fi

print_usage() {
        echo "Usage:"
        echo " $PROGNAME <tunnelname>"
        echo " $PROGNAME <ping-ip> <ping-src-ip>"
        echo " $PROGNAME <ping-ip> <ping-src-ip> rtt"
        echo " $PROGNAME --help"
        echo " $PROGNAME --version"
        echo " Created by Andre Schild, questions or problems e-mail andre@schild.ws"
		echo ""
}

print_help() {
        print_usage
        echo " Checks vpn connection status of an openswan or strongswan installation."
		echo ""
        echo " <tunnelname> Check if the given tunnel is active"
	echo " <ping-ip> <ping-src-ip> ping the remote IP via tunnel, using the given source IP address"
	echo " <ping-ip> <ping-src-ip> rtt ping the remote IP via tunnel, using the given source IP address, return round trip time"
		echo ""
        echo " --help"
		echo " -h"
        echo " prints this help screen"
		echo ""
        echo ""
}

ping_tunnel() {

	IP_DEST="$1"
	IP_SRC="$2"

        alive=`$FPINGBIN -r 1 -S $IP_SRC $IP_DEST | awk '{print $3}'`

        if [[ "$alive" = "alive" ]]
        then
            echo 1
        else
            echo 0
        fi
}


ping_tunnel_rtt() {

	IP_DEST="$1"
	IP_SRC="$2"

    rtt=`$FPINGBIN -r 1 -e -S $IP_SRC $IP_DEST | awk '{print $4}' | sed 's/(//g'`
		
	echo $rtt

}



test_tunnel() {

	CONN="$1"
	
	    tunneltest=`$IPSECCMD status $CONN | grep -e "ESTABLISHED" | wc -l`
	    
	
	if [[ "$tunneltest" -eq "0" ]]
    then
	echo 0
    else
	echo 1
    fi
}


case "$1" in
--help)
        print_help
        exit $STATE_OK
        ;;
-h)
        print_help
        exit $STATE_OK
        ;;
*)
	if [ $# -eq 1 ]
	then
    	    test_tunnel $1
    	else
	    if [ $# -eq 2 ]
	    then
    		ping_tunnel $1 $2
    	    else
    		    print_help
    	fi
    fi
        ;;

esac

