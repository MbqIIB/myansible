#!/bin/bash 

#uuids=$(awk -F ' ' '{print $2}' cp0_ACTIVE.txt)
#uuids=$(awk -F ' ' '{print $2}' cp4_ACTIVE.txt)
#uuids=$(awk -F ' ' '{print $2}' cp5_ACTIVE.txt)
#uuids=$(awk -F ' ' '{print $2}' alltenants.log.err.active)
#uuids=$(awk -F '|' '{print $5}' allimage.log.saving)
uuids=$(awk -F ' ' '{print $2}' alltenants.log.active)

t=1
set -x
for id in ${uuids[@]}
do

    echo $id
    nova stop $id

    #while true;
    #do
    #    #check
    #    nova list --all-tenants --host $HOST | grep $id | grep  "SHUTOFF"
    #
    #        if [ $? == 0 ]
    #        then
    #        echo "still wait stop $id"
    #         break
    #        fi
    #        sleep 5

    #done
    echo "sleep ${t} to next"
    sleep ${t}

done

