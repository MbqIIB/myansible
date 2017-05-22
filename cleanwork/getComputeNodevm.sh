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

#ComputeNode=op-icehouse-cp0.ibm.com
#ComputeNode=op-icehouse-cp2.ibm.com
#ComputeNode=op-icehouse-cp3.ibm.com
#ComputeNode=op-icehouse-cp4-lxc.ibm.com
#ComputeNode=xContainer
#ComputeNode=op-icehouse-cp5-lxc.ibm.com
#ComputeNode=compute-cp6-ppc-BE-kvm.ibm.com
#ComputeNode=compute-cp7-ppc-BE-kvm.ibm.com
#ComputeNode=opower-gpfs2
#ComputeNode=opower-gpfs3
ComputeNode=compute-cp8-ppc-LE-docker
#ComputeNode=xContainer
#ComputeNode=xContainer1
#ComputeNode=xContainer2
#ComputeNode=xContainer3
#ComputeNode=compute-cp9-ppc-LE-docker
#ComputeNode=compute-cp10-ppc-LE-kvm.ibm.com
#ComputeNode=compute-cp11-ppc-LE-kvm.ibm.com
#ComputeNode=compute-cp12-ppc-LE-kvm.ibm.com
#ComputeNode=compute-cp13-ppc-LE-docker
#ComputeNode=x3550m5n01.ibm.com
#ComputeNode=chuanghe1.ibm.com
#ComputeNode=chuanghe2.ibm.com
#ComputeNode=chuanghe3.ibm.com
#ComputeNode=neucloud4

#ComputeNode=ent-cp6-ppc64le.ibm.com

nova list --all-tenants  --host ${ComputeNode} > ${logall}

cat ${logall} | grep "ERROR" > ${logallerror}
cat ${logall} | grep "ACTIVE" > ${logallactive}
cat ${logall} | grep "Shutdown" > ${logallshutdown}
cat ${logall} | grep "delete" > ${logalldeleteing}
cat ${logall} | grep "powering-on" > ${logallpoweron}
cat ${logall} | grep "powering-off" > ${logallpoweroff}
cat ${logall} | grep "PAUSED" > ${logallpause}

popd
