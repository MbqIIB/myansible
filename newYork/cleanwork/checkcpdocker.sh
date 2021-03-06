#!/bin/bash 

set -x
CURDIR=`pwd`

echo $CURDIR
dockerlist=dockerlist.log
cplist=cplist.log

uuids=$(awk -F '|' '{print $1}' ${dockerlist})

#set -x
for id in ${uuids[@]}
do
    echo "Check $id"
    grep $id ${cplist}
    if [ $? != 0 ];then
        echo $id >> ${cplist}.nonfind
        grep $id ${dockerlist}  >>  ${dockerlist}.nonfindvm
        continue
    fi
    grep $id ${cplist} >> ${cplist}.find
    grep $id ${dockerlist}  >>  ${dockerlist}.findvm

done

echo "Done"
