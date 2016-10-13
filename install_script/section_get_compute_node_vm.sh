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
source /root/openrc

OPDIR=/home/poweroff
if [ ! -d ${OPDIR} ]
then
	mkdir -p ${OPDIR}
fi

pushd ${OPDIR} 

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

nova list --all-tenants  --host `hostname` >  ${logall}

cat ${logall} | grep "ERROR"         > ${logallerror}
cat ${logall} | grep "ACTIVE"        > ${logallactive}
cat ${logall} | grep "Shutdown"      > ${logallshutdown}
cat ${logall} | grep "delete"        > ${logalldeleteing}
cat ${logall} | grep "powering-on"   > ${logallpoweron}
cat ${logall} | grep "powering-off"  > ${logallpoweroff}
cat ${logall} | grep "PAUSED"        > ${logallpause}

uuids=$(awk -F ' ' '{print $2}' ${logallactive})
for id in ${uuids[@]}
do

        echo $id
        nova stop $id

        echo "sleep 1 to next"
        sleep 1
done

popd
popd #OPDIR
