#!/bin/bash 

uuids=$(awk -F ' ' '{print $2}' image2015.log)

HOST=""
set -x
for id in ${uuids[@]}
do

    echo $id
    nova image-delete $id


    #done
    echo "sleep 5 to next"
    sleep 5


done

