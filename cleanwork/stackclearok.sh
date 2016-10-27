#!/bin/bash

#set -x
tidlist=$(awk -F ' ' '{print $6}' stacklist.log.ok)


function StackDelete()
{
	sid=$1
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
}


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

	sid_name=$(grep $tid stacklist.log.ok | awk -F ' ' '{print $4}')
	nova list --all-tenants --tenant $tid | grep $sid_name
	if [ $? != 0 ];then
		echo "======================= Will Delete ===================="
		nova list
		sleep 2
		StackDelete $sid_name
		heat stack-list
	    nova list --all-tenants --tenant $tid
	else
		echo "======================= Do Not Delete ===================="
	fi

	sleep 5
done

