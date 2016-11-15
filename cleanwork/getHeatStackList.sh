#!/bin/bash -

set -o nounset                              # Treat unset variables as an error

DATETIME=$(date  '+%Y%m%d_%H%M%S')

logdir=computeNode_log_${DATETIME}

if [ ! -d ${logdir} ]
then
    mkdir ${logdir}
fi

pushd ${logdir}


logname=stacklist
logall=${logname}.log
logallcreatefailed=${logname}_createfailed.log
logallcreatecomplete=${logname}_createcomplete.log
logalldeletefailed=${logname}_deletefailed.log
logallnonecomplete=${logname}_nonecomplete.log

heat stack-list -g > ${logall}

cat ${logall} | grep "CREATE_FAILED"        > ${logallcreatefailed}
cat ${logall} | grep "CREATE_COMPLETE"      > ${logallcreatecomplete}
cat ${logall} | grep "DELETE_FAILED"        > ${logalldeletefailed}
cat ${logall} | grep  -v "CREATE_COMPLETE" | grep -v "| id" | grep -v "^+-" > ${logallnonecomplete}

popd
