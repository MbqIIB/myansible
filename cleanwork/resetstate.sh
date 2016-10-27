#!/bin/bash 

#uuids=$(awk -F ' ' '{print $2}' alltenants.log.err)
#uuids=$(awk -F ' ' '{print $2}' alltenants.log.err.off)
uuids=$(awk -F ' ' '{print $2}' alltenants.log.err)

set -x
for id in ${uuids[@]}
do

	echo $id
	nova reset-state --active $id
	sleep 1
	nova stop $id

	#while true;
	#do
	#	#check
	#	nova list --all-tenants --host $HOST | grep $id | grep  "SHUTOFF"
	#
	#        if [ $? == 0 ]
	#        then
	#		echo "still wait stop $id"
	#	     break
	#        fi
	#        sleep 5

	#done
        #echo "sleep 1 to next"
       sleep 5
       nova start $id
	

done

