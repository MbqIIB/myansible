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

logdir=log_image_${DATETIME}

if [ ! -d ${logdir} ]
then
    mkdir ${logdir}
fi

pushd ${logdir}


logname=allimage
logall=${logname}.log
logallerror=${logname}.log.err
logallactive=${logname}.log.active
logallsaving=${logname}.log.saving

nova image-list > ${logall}

cat ${logall} | grep "ERROR" > ${logallerror}
cat ${logall} | grep "ACTIVE" > ${logallactive}
cat ${logall} | grep "SAVING" > ${logallsaving}

popd
