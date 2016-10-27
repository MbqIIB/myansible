#!/bin/bash

set -x
logname=stacklist
logall=${logname}.log
logallcreatefailed=${logname}_createfailed.log
logallcreatecomplete=${logname}_createcomplete.log
logalldeletefailed=${logname}_deletefailed.log

passfile=stackpass.txt

sidlist=$(awk -F ' ' '{print $2}' ${logallcreatefailed})


for sid in ${sidlist[@]}
do
    tid=$(grep $sid ${logallcreatefailed} | awk -F ' ' '{print $6}')
    tidinfo=$(grep $tid ${passfile})
    if [ $? != 0 ];then
		echo "$tidinfo==xxxxxxxxxxxxxxxxxxxxxxx"
	else
		echo "$tidinfo"
	fi
	user=$(echo "$tidinfo" | awk -F ',' '{print $6}' | awk -F ' ' '{print $1}')
	pass=$(echo "$tidinfo" | awk -F ',' '{print $7}' | awk -F ' ' '{print $1}')

	export OS_USERNAME="${user}"
	export OS_PASSWORD="${pass}"
	export OS_TENANT_NAME=${OS_USERNAME}

	heat stack-list
	heat stack-delete ${sid}

	while true;
	do
		heat stack-list | grep ${sid}
		if [ $? == 0 ];then
		    sleep 2
			continue
		else 
			break
		fi
	done
	sleep 1
done
