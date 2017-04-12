#!/bin/bash 

#uuids=$(awk -F ' ' '{print $2}' image2015.log)
#uuids=$(awk -F ' ' '{print $2}' 20170105imagelist.log)
#filename=allimage.log.saving.nonfindvm
filename=allimage.log.saving
uuids=$(awk -F ' ' '{print $2}' $filename)

HOST=""
set -x
for id in ${uuids[@]}
do

    echo $id
    grep $id ${filename}
    nova image-delete $id


    #done
    echo "sleep 1 to next"
    sleep 1


done

