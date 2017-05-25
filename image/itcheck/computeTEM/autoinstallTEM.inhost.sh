#!/bin/bash - 
#===============================================================================
#
#          FILE: autoinstallTEM.inhost.sh
# 
#         USAGE: ./autoinstallTEM.inhost.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 05/22/2017 07:03:28 PM CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

cur_dir=`pwd`
echo "current dir ${cur_dir}"

function installTEM()
{
    docker_id=$1
    echo "${docker_id}"
    #sleep 1
    dockerdir=$(ls -d /var/lib/docker/aufs/mnt/* | grep -v init | grep ${docker_id})
    echo $dockerdir
    BES=${dockerdir}/opt/BESClient
    if [ -d ${BES}  ];then
        echo "BESClient installed"
        return 0
    else
        echo "Will install BESClient"
        cp ${cur_dir}/autoInstallTem.sh ${dockerdir}/tmp/
        docker exec -d ${docker_id} /tmp/autoInstallTem.sh
    fi
}


function stopTEM()
{
    docker_id=$1
    echo "${docker_id}"
    #sleep 1
    dockerdir=$(ls -d /var/lib/docker/aufs/mnt/* | grep -v init | grep ${docker_id})
    echo $dockerdir
    BES=${dockerdir}/opt/BESClient
    if [ -d ${BES}  ];then
        echo "BESClient stop"
        cp ${cur_dir}/autoStopTem.sh ${dockerdir}/tmp/
        docker exec -d ${docker_id} /tmp/autoStopTem.sh

    fi
}

function startTEMcentos()
{
    docker_id=$1
    echo "${docker_id}"
    #sleep 1
    dockerdir=$(ls -d /var/lib/docker/aufs/mnt/* | grep -v init | grep ${docker_id})
    echo $dockerdir

    if [ -f ${dockerdir}/etc/system-release ];then
        cat ${dockerdir}/etc/system-release
    else
        return 0
    fi

    BES=${dockerdir}/etc/init.d/besclient
    if [ -f ${BES}  ];then
        echo "BESClient Start in CentOS7"
        cp ${cur_dir}/autoStartTem.sh ${dockerdir}/tmp/
        docker exec -d ${docker_id} /tmp/autoStartTem.sh
    fi
}



function startTEM()
{
    docker_id=$1
    echo "${docker_id}"
    #sleep 1
    dockerdir=$(ls -d /var/lib/docker/aufs/mnt/* | grep -v init | grep ${docker_id})
    echo $dockerdir
    BES=${dockerdir}/etc/init.d/besclient
    if [ -f ${BES}  ];then
        echo "BESClient Start"
        cp ${cur_dir}/autoStartTem.sh ${dockerdir}/tmp/
        docker exec -d ${docker_id} /tmp/autoStartTem.sh

    fi
}



function main()
{
    alldockerid=$(docker  ps | grep -v CONTAINER | awk -F ' ' '{print $1}')
    for id in ${alldockerid[@]};
    do
        #installTEM $id
        #stopTEM $id
        #startTEM $id
        startTEMcentos $id
        sleep 2
    done
}
main
echo "Finished"

