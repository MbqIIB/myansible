#!/bin/bash

set -x

Time=$(date '+%Y%m%d_%H%M%S')

Gimagelist=gimagelist.${Time}.log
Nimagelist=nimagelist.${Time}.log

glance image-list > $Gimagelist
nova image-list > $Nimagelist

imagelist=( \
CentOS7.3-x86_64-20G-nocheck_v1 \
)


for name in ${imagelist[@]}
do
    echo ${name}

    imageid=$(grep $name $Gimagelist | awk -F '|' '{print $2}')
    suf=$(glance image-show ${imageid} | grep "^| disk_format" | awk -F ' ' '{print $4}')
    echo ${name}.${suf}

    echo "start download ${name}"
    glance image-download \
        --file ${name}.${suf} ${imageid}
    
#    chown opadmin:opadmin ${name}.${suf}
    echo "sleep 10 s"
    sleep 10
done

echo "Finish"

