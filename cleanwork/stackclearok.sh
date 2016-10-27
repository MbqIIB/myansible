#!/bin/bash

#set -x
logname=stacklist
logall=${logname}.log
logallcreatefailed=${logname}_createfailed.log
logallcreatecomplete=${logname}_createcomplete.log
logalldeletefailed=${logname}_deletefailed.log

passfile=stackpass.txt

sidlist=$(awk -F ' ' '{print $2}' ${logallcreatecomplete})

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
	            echo "======================= Delete Success ===================="
		fi
	done
}


for sid in ${sidlist[@]}
do
    tid=$(grep $sid ${logallcreatecomplete} | awk -F ' ' '{print $6}')
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

	sid_name=$(grep $sid ${logallcreatecomplete} | awk -F ' ' '{print $4}')
	nova list --all-tenants --tenant $tid | grep $sid_name
	if [ $? != 0 ];then
	    echo "======================= Will Delete ===================="
	    nova list
	    sleep 2
	    StackDelete $sid
	    heat stack-list
	    nova list --all-tenants --tenant $tid
	else
		echo "======================= Do Not Delete ===================="
	fi

	sleep 5
done

