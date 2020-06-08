#!/bin/bash
#
# calcula o tamanho total do MySQL
if [ "$1" == "all" ]
then
        acumulador=0
        total=/tmp/mysql_size_all.tmp
        echo "SELECT sum(round(((data_length + index_length)))) as 'size' FROM information_schema.TABLES GROUP BY table_schema;" | mysql --defaults-extra-file=/etc/zabbix/my.conf | sed -e '1d' | while read valores
                do

                        if [ $valores -ge 0 ]
                        then

                                acumulador=$(($acumulador+$valores))

                        fi

                        echo $acumulador > $total

                done

                cat $total

# calcula o tamanho de um BD especifico
elif [ -n $1 ]
then

        echo "SELECT sum(round(((data_length + index_length)))) as 'size' FROM information_schema.TABLES WHERE table_schema = '$1' ;" | mysql --defaults-extra-file=/etc/zabbix/my.conf | tail -n 1

# Chave invalida
else

        echo ZBX_NOTSUPPORTED

fi