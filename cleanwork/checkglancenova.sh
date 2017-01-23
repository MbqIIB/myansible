#!/bin/bash 

set -x
curdir=`pwd`
#imagefile=allimage.log.saving
imagefile=allimage.log
glanceimage=glanceimagelist

uuids=$(awk -F '|' '{print $2}' ${imagefile})

#set -x
for id in ${uuids[@]}
do
    echo "Check $id"
    grep $id ${glanceimage}
    if [ $? != 0 ];then
        echo $id >> ${glanceimage}.nonfind
        grep $id ${imagefile}  >>  ${imagefile}.nonfind
        continue
    fi
    echo $id >> ${glanceimage}.find
    grep $id ${imagefile}  >>  ${imagefile}.find
    #sleep 1
    

done

echo "Done"
