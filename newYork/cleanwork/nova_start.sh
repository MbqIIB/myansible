#!/bin/bash

#uuids=$(awk -F ' ' '{print $2}' cp0_master_ACTIVE.txt)
#uuids=$(awk -F ' ' '{print $2}' cp4_master_ACTIVE.txt)
#uuids=$(awk -F ' ' '{print $2}' cp0_ACTIVE.txt)
#uuids=$(awk -F ' ' '{print $2}' cp4_ACTIVE.txt)
#uuids=$(awk -F ' ' '{print $2}' cp4_ACTIVE.txt2)
#uuids=$(awk -F ' ' '{print $2}' cp5_ACTIVE.txt)
#uuids=$(awk -F ' ' '{print $1}' cp8stop)
#uuids=$(awk -F ' ' '{print $2}' cp5_20150824_ACTIVE.txt)
#uuids=$(awk -F ' ' '{print $2}' x0_ACTIVE.txt)
#uuids=$(awk -F ' ' '{print $2}' x1)
uuids=$(awk -F ' ' '{print $2}' alltenants.log.err.active)

#HOST="op-icehouse-cp5-lxc.ibm.com"
HOST="op-icehouse-cp0.ibm.com"
set -x
for id in ${uuids[@]}
do

    echo $id
    nova start $id

    #while true;
    #do
    #   #check
    #   nova list --all-tenants --host $HOST | grep $id | grep  "SHUTOFF"
    #
    #        if [ $? == 0 ]
    #        then
    #           echo "still wait stop $id"
    #        break
    #        fi
    #        sleep 5

    #done
    echo "sleep 5 to next"
    sleep 5


done
