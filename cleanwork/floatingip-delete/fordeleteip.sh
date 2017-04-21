#!/bin/bash

set -x
source /root/openrc

pushd /home/linzhbj/floatingip-delete/
DATETIME=$(date  '+%Y%m%d_%H%M%S')

logdir=floatingip_log_${DATETIME}

if [ ! -d ${logdir} ]
then
    mkdir ${logdir}
fi

pushd ${logdir}



logfile=floatingip
neutron floatingip-list | grep "| 172" | grep "| \+ |" > ${logfile}

#exit 0

list=$(awk -F ' ' '{print $2}' ${logfile})

for ip in ${list[@]}
do

    echo "$ip"

    grep $ip ${logfile}
    neutron floatingip-delete ${ip}
done

popd
popd # /home/linzhbj/floatingip-delete/
