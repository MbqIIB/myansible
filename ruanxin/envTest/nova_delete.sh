#!/bin/bash 

uuids=$(awk -F ' ' '{print $2}' docker.log)

HOST=""
set -x
for id in ${uuids[@]}
do

    echo $id
    nova show $id
    sleep 5
    nova delete $id


    #done
    echo "sleep 5 to next"
    sleep 5


done

