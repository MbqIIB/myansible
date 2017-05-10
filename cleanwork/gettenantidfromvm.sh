#!/bin/bash
set -x
#uuids=$(awk -F ' ' '{print $2}' uuids.txt)
uuids=$(awk -F '|' '{print $2}' alltenants.log.nonet)
for id in ${uuids[@]}
do
	echo $id
	tenantid=$(nova show ${id} | grep tenant_id |awk -F ' ' '{print $4}' )
        echo ${tenantid}
	echo ${tenantid} >> tenantids.txt
#	mail=$(keystone user-get ${userid} |  grep email |awk -F ' ' '{print $4}')
#	echo ${mail} >> maillist.txt
        sleep 1
	
done

#cat maillist.txt | uniq

