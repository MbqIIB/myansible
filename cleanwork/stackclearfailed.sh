#!/bin/bash

set -x
tidlist=$(awk -F ' ' '{print $6}' stacklist.log.failed)

for tid in ${tidlist[@]}
do
	tidinfo=$(grep $tid stackpass.txt)
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
	sid_err=$(grep $tid stacklist.log.failed | awk -F ' ' '{print $2}')
	heat stack-delete ${sid_err}

	while true;
	do
		heat stack-list | grep ${sid_err}
		if [ $? == 0 ];then
		    sleep 1
			continue
		else 
			break
		fi
	done
	sleep 1
done

