#!/bin/bash

if [ -f /root/openrc ]; then
. /root/openrc
fi

logfile=/home/linzhbj/servicemonitor/curlog/servicecheck.log
logfiletmp=/home/linzhbj/servicemonitor/curlog/servicecheck.log.tmp

HOSTNAME=`hostname`

localtime=$(date +"%Y%m%d_%H%M%S")
echo "=============== start ${localtime} ==========="

nova service-list >  ${logfiletmp}
if [ $? != 0 ];then
	echo "service-list error"
fi

cat ${logfiletmp} | grep  "${HOSTNAME}" | grep 'down'
if [ $? != 0 ];then
	echo "${HOSTNAME} is ok"
else
	echo "restart service"
        date -u +"%Y%m%d_%H%M%S"
	/root/p8servicerestart.sh stop
	/root/p8servicerestart.sh start
fi
echo "=============== start ${localtime} ==========="

