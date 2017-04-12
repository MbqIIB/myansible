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

logdir=computeNode_log_${DATETIME}

if [ ! -d ${logdir} ]
then
    mkdir ${logdir}
fi

pushd ${logdir}


logname=alltenants
logall=${logname}.log
logallerror=${logname}.log.err
logallactive=${logname}.log.err.active
logallshutdown=${logname}.log.err.shutdown
logalldeleteing=${logname}.log.err.del
logallpoweron=${logname}.log.err.on
logallpoweroff=${logname}.log.err.off
logallpause=${logname}.log.err.pause

#ComputeNode=svf1
#ComputeNode=svf2

ComputeNode=svx11
ComputeNode=svx12
ComputeNode=svx13
ComputeNode=svx14
ComputeNode=svx15
ComputeNode=svx16
ComputeNode=svx17
ComputeNode=svx18

nova list --all-tenants  --host ${ComputeNode} > ${logall}

cat ${logall} | grep "ERROR"         > ${logallerror}
cat ${logall} | grep "ACTIVE"        > ${logallactive}
cat ${logall} | grep "Shutdown"      > ${logallshutdown}
cat ${logall} | grep "delete"        > ${logalldeleteing}
cat ${logall} | grep "powering-on"   > ${logallpoweron}
cat ${logall} | grep "powering-off"  > ${logallpoweroff}
cat ${logall} | grep "PAUSED"        > ${logallpause}

popd
