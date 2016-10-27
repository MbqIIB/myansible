#!/bin/bash
set -x
uuids=$(awk -F ' ' '{print $2}' uuids.txt)
for id in ${uuids[@]}
do
	echo $id
	userid=$(nova show ${id} | grep user_id |awk -F ' ' '{print $4}' )
	echo ${userid} >> userids.txt
#	mail=$(keystone user-get ${userid} |  grep email |awk -F ' ' '{print $4}')
#	echo ${mail} >> maillist.txt
	
done

#cat maillist.txt | uniq

