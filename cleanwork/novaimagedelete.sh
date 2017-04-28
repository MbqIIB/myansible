#!/bin/bash 

#uuids=$(awk -F ' ' '{print $2}' image2015.log)
#uuids=$(awk -F ' ' '{print $2}' 20170105imagelist.log)
#filename=allimage.log.saving.nonfindvm
#filename=allimage.log.saving
#filename=nimagelist.20170425_152149.log.16-12-28.log
#filename=nimagelist.20170426_084933.log.16-12-29.log
#filename=nimagelist.20170426_114515.log.16-12-30.log
#filename=nimagelist.20170426_141101.log.16-12-31.log
filename=nimagelist.20170426_171431.log.17-01.log
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

