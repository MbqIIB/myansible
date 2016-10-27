#!/bin/bash

set -x
tidlist=$(awk -F ' ' '{print $6}' stacklist.log )

tenantlist=stackTenantList.txt
> ${tenantlist}
for tid in ${tidlist[@]}
do
	tenant=$(grep $tid alltenantlist.log)
        if [ $? != 0 ];then
			echo "$tid==xxxxxxxxxxxxxxxxxxxxxxx" >> ${tenantlist}
		else
			echo "$tenant" >> ${tenantlist}
		fi
done


cat ${tenantlist} | grep True | sort | uniq > ${tenantlist}.uniq
