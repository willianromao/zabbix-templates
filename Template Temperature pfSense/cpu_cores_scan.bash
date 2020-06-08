#!/usr/local/bin/bash

ncores=$( sysctl hw.ncpu | awk '{ print $2 }' )

get_cores() {

ultimalinha=$[$ncores-1]

echo '{"data":['

for ((core=0;$core<$ncores;core++))
do
        if [ $ultimalinha = $core ] ; then
                echo '{"{#CORES}":"'$core'"}'
        else
                echo '{"{#CORES}":"'$core'"},'
        fi
done

echo ']}'

}

if [ $ncores -ge '0' ] ; then
        get_cores
else
        echo ZBX_NOTSUPPORTED
fi
exit 0