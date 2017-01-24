#!/bin/bash


DateTime=$(date +%Y%m%d_%H%M%S)
TenantListFile=alltenant${DateTime}.txt
UserTenantList=User_${TenantListFile}

OldTenantlist=alltenant20170116_103707.txt

keystone tenant-list > ${TenantListFile}

#filter admin service
cat ${TenantListFile} | grep -v "^\+" | grep -v " id " | grep -v " admin " | grep -v " service " > ${UserTenantList}

#alltenant=$(awk -F ' ' '{print $2}' alltenant.txt)
alltenant=$(awk -F ' ' '{print $2}' ${UserTenantList})
#alltenant=$(awk -F ' ' '{print $2}' usagelisttenant.txt)

#set -x
#exit 0

> ${UserTenantList}.new
> ${UserTenantList}.old

for  tenantid in ${alltenant[@]}
do
        grep ${tenantid} ${OldTenantlist}
        if [ $? == 0 ];then
             grep ${tenantid} ${OldTenantlist} >> ${UserTenantList}.old
             #sleep 1
             continue
        else 
             grep ${tenantid} ${UserTenantList} >> ${UserTenantList}.new
        fi

	echo "${tenantid}"
	grep ${tenantid} ${UserTenantList}
	#neutron security-group-list --tenant-id  ${tenantid}
	#sleep 1

       defaultid=$(neutron security-group-list --tenant-id  ${tenantid} | grep " default " | awk -F ' ' '{print $2}')

       oldinfo=$(neutron security-group-show ${defaultid} --tenant-id  ${tenantid})
       echo "${oldinfo}"
       #defaultid=$( echo "${oldinfo}" | grep " default " | awk -F ' ' '{print $2}')
#	sleep 1

       #break

       #add group

        echo "${oldinfo}" | grep "icmp" #|  grep "0.0.0.0"  
        if [ $? != 0 ];then
               echo "add secgroup icmp port"
	       neutron security-group-rule-create --tenant-id ${tenantid} \
	       	--direction ingress \
	       	--protocol icmp \
	       	--remote-ip-prefix 0.0.0.0/0 \
	       	${defaultid}
               echo "${tenantid}" >> ${UserTenantList}.port_icmp.log
               
        fi

        echo "${oldinfo}" | grep " 22, " #|  grep "0.0.0.0"  
        if [ $? != 0 ];then
               echo "add secgroup 22 port"
	       neutron security-group-rule-create --tenant-id ${tenantid} \
	       	--direction ingress \
	       	--protocol tcp \
	       	--port-range-min 22 \
	       	--port-range-max 22 \
	       	--remote-ip-prefix 0.0.0.0/0 \
	       	${defaultid}
               echo "${tenantid}" >> ${UserTenantList}.port_22.log
        fi

        echo "${oldinfo}" | grep " 4200," #|  grep "0.0.0.0"  
        if [ $? != 0 ];then
               echo "add secgroup 4200 port"
	       neutron security-group-rule-create --tenant-id ${tenantid} \
	       	--direction ingress \
	       	--protocol tcp \
	       	--port-range-min 4200 \
	       	--port-range-max 4200 \
	       	--remote-ip-prefix 0.0.0.0/0 \
	       	${defaultid}
               echo "${tenantid}" >> ${UserTenantList}.port_4200.log
        fi

####        echo "${oldinfo}" | grep " 5900, " | grep " 5910," #|  grep "0.0.0.0"  
####        if [ $? != 0 ];then
####               echo "add secgroup 5900-5910 port"
####		neutron security-group-rule-create --tenant-id ${tenantid} \
####			--direction ingress \
####			--protocol tcp \
####			--port-range-min 5900 \
####			--port-range-max 5910 \
####			--remote-ip-prefix 0.0.0.0/0 \
####			${defaultid}
####        fi

####        neutron security-group-rule-create --tenant-id ${tenantid} \
####	--direction ingress \
####	--protocol tcp \
####	--port-range-min 8880 \
####	--port-range-max 8899 \
####	--remote-ip-prefix 0.0.0.0/0 \
####	${defaultid}
####
####        neutron security-group-rule-create --tenant-id ${tenantid} \
####	--direction ingress \
####	--protocol tcp \
####	--port-range-min 3306 \
####	--port-range-max 3306 \
####	--remote-ip-prefix 0.0.0.0/0 \
####	${defaultid}
####
####        neutron security-group-rule-create --tenant-id ${tenantid} \
####	--direction ingress \
####	--protocol tcp \
####	--port-range-min 5000 \
####	--port-range-max 5000 \
####	--remote-ip-prefix 0.0.0.0/0 \
####	${defaultid}
####
####        neutron security-group-rule-create --tenant-id ${tenantid} \
####	--direction ingress \
####	--protocol tcp \
####	--port-range-min 4040 \
####	--port-range-max 4050 \
####	--remote-ip-prefix 0.0.0.0/0 \
####	${defaultid}
####
####        neutron security-group-rule-create --tenant-id ${tenantid} \
####	--direction ingress \
####	--protocol tcp \
####	--port-range-min 8080 \
####	--port-range-max 8080 \
####	--remote-ip-prefix 0.0.0.0/0 \
####	${defaultid}
####
####        neutron security-group-rule-create --tenant-id ${tenantid} \
####	--direction ingress \
####	--protocol tcp \
####	--port-range-min 9000 \
####	--port-range-max 9000 \
####	--remote-ip-prefix 0.0.0.0/0 \
####	${defaultid}
####        neutron security-group-rule-create --tenant-id ${tenantid} \
####	--direction ingress \
####	--protocol tcp \
####	--port-range-min 50010 \
####	--port-range-max 50010 \
####	--remote-ip-prefix 0.0.0.0/0 \
####	${defaultid}
####	#sleep 1
#	neutron security-group-list --tenant-id  ${tenantid}
done

