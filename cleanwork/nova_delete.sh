#!/bin/bash 

uuids=$(awk -F ' ' '{print $2}' alltenants.log.err)
#uuids=$(awk -F ' ' '{print $2}' alltenants.log.err.nostate)
#uuids=$(awk -F ' ' '{print $2}' alltenants.log.err.active)
#uuids=$(awk -F ' ' '{print $2}' alltenants.log.err.shutdown)

#HOST="op-icehouse-cp5-lxc.ibm.com"
#HOST="op-icehouse-cp2.ibm.com"
HOST="op-icehouse-cp4-lxc.ibm.com"
set -x
for id in ${uuids[@]}
do

    echo $id
    nova delete $id


    #done
    echo "sleep 5 to next"
    sleep 3


done

