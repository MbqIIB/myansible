#!/bin/bash

#uuids=$(awk -F ' ' '{print $2}' delete.log)
#uuids=$(awk -F ' ' '{print $1}' powerch.log)
#uuids=$(awk -F ' ' '{print $1}' openroaddel.log)
#filename=openroaddel.log
filename=alltenants.log.err.shutdown
uuids=$(awk -F ' ' '{print $2}' ${filename})
echo "$filename"

set -x
for id in ${uuids[@]}
do

    echo $id
    nova delete $id

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
    echo "sleep 2 to next"
    sleep 2


done
