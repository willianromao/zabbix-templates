#!/usr/local/bin/bash

ncpu=$( sysctl hw.ncpu | awk '{ print $2 }' )

get_temp() {
    if [[ "$1" == "avg" ]]; then
        avg=0

        for c in `jot ${ncpu} 0`; do
            temp=$( sysctl dev.cpu.${c}.temperature | sed -e 's|.*: \([0-9.]*\)C|\1|' )
            avg=$( echo "${avg} + ${temp}" | bc )
        done

        avg=$( echo "${avg} / (${ncpu})" | bc )
        rc=${avg}
    else
        temp=$( sysctl dev.cpu.${1}.temperature | sed -e 's|.*: \([0-9.]*\)C|\1|' )
        rc=${temp}
    fi

    echo $rc
}

get_temp $1
exit 0