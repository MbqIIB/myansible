#!/bin/bash

uuids=$(awk -F ' ' '{print $1}' clearlist20161026.log)

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
    echo "sleep 5 to next"
    sleep 5


done
