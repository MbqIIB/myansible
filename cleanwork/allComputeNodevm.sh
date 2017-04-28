#!/bin/bash -
#===============================================================================
#
#          FILE: getallvm.sh
#
#         USAGE: ./getallvm.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (),
#  ORGANIZATION:
#       CREATED: 2015年09月02日 13时18分37秒 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

DATETIME=$(date  '+%Y%m%d_%H%M%S')

logdir=allComputeNode_log_${DATETIME}

HostFile=hostfile.log
ComputeHost=computehost.log

if [ ! -d ${logdir} ]
then
    mkdir ${logdir}
fi

logname=alltenants
logall=${logname}.log
logallerror=${logname}.log.err
logallactive=${logname}.log.active
logallshutdown=${logname}.log.shutdown
logalldeleteing=${logname}.log.del
logallpoweron=${logname}.log.on
logallpoweroff=${logname}.log.off
logallpause=${logname}.log.pause

function getcomputevm()
{
    ComputeNode=$1
    mkdir ${ComputeNode}
    pushd ${ComputeNode}
    nova list --all-tenants  --host ${ComputeNode} > ${logall}

    cat ${logall} | grep "ERROR" > ${logallerror}
    cat ${logall} | grep "ACTIVE" > ${logallactive}
    cat ${logall} | grep "Shutdown" > ${logallshutdown}
    cat ${logall} | grep "delete" > ${logalldeleteing}
    cat ${logall} | grep "powering-on" > ${logallpoweron}
    cat ${logall} | grep "powering-off" > ${logallpoweroff}
    cat ${logall} | grep "PAUSED" > ${logallpause}
    popd
}
function gethostlist()
{
    nova host-list >$HostFile 2>&1
    cat $HostFile | grep "| compute " > $ComputeHost
}
function main()
{
    set -x
    gethostlist
    cplist=$(awk -F '|' '{print $2}' $ComputeHost)
    for cp in ${cplist[@]}
    do
        echo $cp
        getcomputevm $cp
    done
}


pushd ${logdir}
# main here
main
popd
