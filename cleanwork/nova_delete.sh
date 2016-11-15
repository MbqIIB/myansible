#!/bin/bash 

#uuids=$(awk -F ' ' '{print $2}' alltenants.log.err.nostate)
#uuids=$(awk -F ' ' '{print $2}' alltenants.log.err.active)
#uuids=$(awk -F ' ' '{print $2}' alltenants.log.err.shutdown)
#uuids=$(awk -F ' ' '{print $2}' Spark-1.4.0-RHEL-7.1-ppc64le-docker-bigdata-v0.0.6RC-shell.log)
uuids=$(awk -F ' ' '{print $2}' alltenants.log.err)

HOST=""
set -x
for id in ${uuids[@]}
do

    echo $id
    nova delete $id


    #done
    echo "sleep 5 to next"
    sleep 5


done

