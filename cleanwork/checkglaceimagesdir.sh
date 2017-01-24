#!/bin/bash 

set -x
curdir=`pwd`
glanceimage=glanceimagelist
imagefile=allimage.log

> ${glanceimage}.find
> ${glanceimage}.nonfind
> ${glanceimage}.nonfind.log
> ${imagefile}.find
> ${imagefile}.nonfind

uuids=$(awk -F ' ' '{print $9}' ${glanceimage})

#set -x
for id in ${uuids[@]}
do
    echo "Check $id"
    grep $id ${imagefile}
    if [ $? != 0 ];then
        echo $id >> ${glanceimage}.nonfind
        grep $id ${glanceimage}  >>  ${glanceimage}.nonfind.log
        continue
    fi
    echo $id >> ${glanceimage}.find
    grep $id ${imagefile}  >>  ${imagefile}.find
    #sleep 1
    

done

echo "Done"
