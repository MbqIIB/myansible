#!/bin/bash

set -x

if [ -f /root/openrc ]; then
. /root/openrc
fi

HOSTNAME=`hostname`
DateTime=$(date +%Y%m%d_%H%M%S)

targetdir=/home/linzhbj/servicemonitor
pushd ${targetdir}


if [ -f ${targetdir}/openrc ]; then
echo "own openrc"
. ${targetdir}/openrc
else
echo "root openrc"
. /root/openrc
fi

logfile=${targetdir}/curlog/cur-${HOSTNAME}-${DateTime}.log

${targetdir}/novainfo.py  >> ${logfile}  2>&1

popd




# clear log
days=90
echo "clear before $days days file"
pushd /home/linzhbj/servicemonitor/curlog

/usr/bin/find /home/linzhbj/servicemonitor/curlog/ -type f -name "cur-*" -mtime +${days} -delete

popd
