#!/bin/bash 

set -x
curdir=`pwd`
glanceimage=glanceimagelist
imagefile=allimage.log

uuids=$(awk -F ' ' '{print $1}' ${glanceimage}.nonfind)

echo $uuid
sleep  1
#set -x
for id in ${uuids[@]}
do
    echo "Check $id"
    glance image-show  $id | grep  status
    sleep 1
#    if [ $? != 0 ];then
# 
#    fi

done

echo "Done"
