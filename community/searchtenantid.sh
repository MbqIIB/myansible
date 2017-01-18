#!/bin/bash

set -x

UserTenantList=User_alltenant20170116_103707.txt
UserTenantListPort=alltenant20170116_103707.txt.port_4200.log

alltenant=$(awk -F ' ' '{print $1}' ${UserTenantListPort})


for id in ${alltenant[@]}
do
	grep $id ${UserTenantList} >> tenantid.log
    
done


echo "Done `date`"
