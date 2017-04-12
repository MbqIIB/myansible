#!/bin/bash 

set -x
curdir=`pwd`
imagefile=allimage.log.saving
allvmlist=allvmlist.log

uuids=$(awk -F '|' '{print $5}' ${imagefile})

#set -x
for id in ${uuids[@]}
do
    echo "Check $id"
    grep $id ${allvmlist}
    if [ $? != 0 ];then
        echo $id >> ${allvmlist}.nonfind
        grep $id ${imagefile}  >>  ${imagefile}.nonfindvm
        continue
    fi
    echo $id >> ${allvmlist}.find
    grep $id ${imagefile}  >>  ${imagefile}.findvm
    #sleep 1
    

done

echo "Done"
