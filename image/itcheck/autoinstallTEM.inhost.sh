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

function installTEM()
{
    docker_id=$1
    echo "${docker_id}"
    sleep 1
    dockerdir=$(ls -d /var/lib/docker/aufs/mnt/* | grep -v init | grep ${docker_id})
    echo $dockerdir
    BES=${dockerdir}/opt/BESClient
    if [ -d ${BES}  ];then
        echo "BESClient installed"
        return 0
    else
        echo "Will install BESClient"
        cp /root/autoInstallTem.sh ${dockerdir}/tmp/
        docker exec -d ${docker_id} /tmp/autoInstallTem.sh
    fi
}

function main()
{
    alldockerid=$(docker  ps | grep -v CONTAINER | awk -F ' ' '{print $1}')
    for id in ${alldockerid[@]};
    do
        installTEM $id
        sleep 5
    done
}
main
echo "Finished"





