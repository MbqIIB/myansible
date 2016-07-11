#!/bin/bash

if [ -f /root/openrc ]; then
. /root/openrc
fi

HOSTNAME=`hostname`

localtime=$(date +"%Y%m%d_%H%M%S")
echo "=============== start ${localtime} ==========="

nova service-list >> curlog/servicecheck.log
if [ $? != 0 ];then
	echo "service-list error"
fi

cat curlog/servicecheck.log | grep  "${HOSTNAME}" | grep 'down'
if [ $? != 0 ];then
	echo "${HOSTNAME} is ok"
else
	echo "restart service"
        date -u +"%Y%m%d_%H%M%S"
	/root/p8servicerestart.sh stop
	/root/p8servicerestart.sh start
fi
echo "=============== start ${localtime} ==========="

