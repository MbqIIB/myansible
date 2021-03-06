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

logdir=allvm_log_${DATETIME}

if [ ! -d ${logdir} ]
then
    mkdir ${logdir}
fi

pushd ${logdir}


logname=alltenants
logall=${logname}.log
logallerror=${logname}.log.err
logallactive=${logname}.log.active
logallshutdown=${logname}.log.shutdown
logalldeleteing=${logname}.log.del
logallpoweron=${logname}.log.on
logallpoweroff=${logname}.log.off
logallpause=${logname}.log.pause
logallnostate=${logname}.log.nostate

nova list --all-tenants  > ${logall}

cat ${logall} | grep "ERROR" > ${logallerror}
cat ${logall} | grep "ACTIVE" > ${logallactive}
cat ${logall} | grep "Shutdown" > ${logallshutdown}
cat ${logall} | grep "delete" > ${logalldeleteing}
cat ${logall} | grep "powering-on" > ${logallpoweron}
cat ${logall} | grep "powering-off" > ${logallpoweroff}
cat ${logall} | grep "PAUSED" > ${logallpause}
cat ${logall} | grep "NOSTATE" > ${logallnostate}

popd
