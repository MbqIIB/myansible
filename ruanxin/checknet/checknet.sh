#!/bin/bash

#set -x

logfile=/tmp/checknet.log
date

cur_tagid=$(ovs-vsctl show | grep -A 1 "Port management-INT" | grep tag | awk -F ':' '{print $2}' | sed 's/ //')
echo "cur = ${cur_tagid}"
> ${logfile}
/usr/sbin/tcpdump -c 1 -nei br-int host 192.168.32.4 > ${logfile}

new_tagid=$(cat ${logfile} | grep -o 'vlan .\+, p' | awk -F ' ' '{print $2}' | sed 's/,//')
echo "new = ${new_tagid}"

echo "cur=${cur_tagid} new=${new_tagid}"
if [ "X"$cur_tagid == "X"$new_tagid ];then
    echo "do not update"
else
    echo "update tag id"
    ovs-vsctl set port management-INT tag=${new_tagid}
fi

