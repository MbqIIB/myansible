#!/bin/bash

set -x

Time=$(date '+%Y%m%d_%H%M%S')
HOST=$(hostname -s)

Key="16-12"
Key="17-01"
Key="s-"
maindir=/home/cleanwork
bakdir=${maindir}/imageclean_${HOST}_${Time}_${Key}

if [ ! -d ${bakdir} ]
then
    mkdir -p ${bakdir}
fi

pushd ${bakdir}

sleep 1
ImageList=dockerimages_${Time}.log
while true
do
    docker images  > ${ImageList} 2> ${ImageList}.err
    grep  "resource temporarily unavailable" ${ImageList} ${ImageList}.err
    if [ $? == 0 ];then
        t=1
        echo "Get ${ImageList} again after ${t}"
        sleep $t
    else 
        break
    fi
done

ImageListKey=key_${Key}_${ImageList}

cat  ${ImageList} | grep "^${Key}" > ${ImageListKey}

NameList=$(awk -F ' ' '{print $1}' ${ImageListKey})


for  name in ${NameList[@]}
do
    while true
    do
        docker rmi ${name} > ${name}.log 2> ${name}.log.err
        #grep  "TLS-enabled" 
        grep  "is using it" ${name}.log ${name}.log.err
        if [ $? == 0 ];then
            echo "${name} Using"
            break
        fi

        grep  "resource temporarily unavailable" ${name}.log ${name}.log.err
        if [ $? == 0 ];then
            t=1
            echo "Del ${name} again after ${t}"
            sleep $t
        else
            echo "Del ${name} Success"
            break
        fi
    done

done

popd

CurTime=$(date '+%Y%m%d_%H%M%S')
echo "pushd ${bakdir}"
echo "Finish ${CurTime}"
