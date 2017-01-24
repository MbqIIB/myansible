#!/bin/bash                                                                                                                                                                          

if [ ! $# == 1 ];then
    echo "Please usage : ./rc_create.sh  XXX.cfg"
    exit 1
fi

configfile=$1
echo "Done"
echo "${configfile}"

source  ${configfile}

set -x                                                                                                                                                                               

#imagename=Ubuntu14.04.3-ppc64le-KVM-v0.0.3
#node=ent-redpower2.ibm.com
#flavoroption=kvm.8c8g20G

net_id=9d8b2e30-1bd2-4bda-b44b-33c09bb45b87
ext_net=c24ebbf6-8d64-4dd5-b59d-c9a5d66274c0
mang_net=ca699bbc-c793-4a8a-95c3-1ca56f0962d4

echo "${Prefix}-${Node}-${FlavorOption}-${ImageName}"


nova flavor-list | grep ${FlavorOption}
if [ $? != 0 ];then
	echo "Don't have flavor ${FlavorOption}"
	exit 1
fi



#exit 0
for ((i=${Number_start};i<${Number_end};i++))
do
    nodename=$(echo ${Node} | sed "s/ent-//g" | sed "s/.ibm.com//g")
    insname=${Prefix}-${nodename}-${FlavorOption}-n${i}
    InstanceId=$(nova boot \
         --flavor ${FlavorOption} \
         --image   ${ImageName} \
         --nic net-id=${net_id} \
         --nic net-id=${mang_net} \
         --availability-zone nova:${Node}  \
         ${insname} | grep ' id '| awk -F ' ' '{print $4}')

    if [ $? != 0 ];then

        echo "nova error ................"
        exit 1
    fi
         sleep 5
     #fip2=$(nova floating-ip-create ext_net2 | grep "ext_net2" | awk -F ' ' '{print $4}')
     fip2=$(nova floating-ip-create ext_net2 | grep ext_net2 | awk -F ' ' '{print $2}')
         sleep 2
     nova floating-ip-associate ${InstanceId} ${fip2}
         sleep 5

     if [ "X${Volume}" != "X" ];then
	#cinder create --display-name ${VolumePrefix}_${Volume}_v${i} --availability-zone gpfs ${Volume}
        nova stop ${InstanceId}
	sleep 5
        while true;
	do 
      		nova list | grep ${InstanceId} | grep "SHUTOFF"
		if [ $? != 0 ];then
			echo "wait 2s"
			sleep 2
			continue
		else 
			break
		fi
	done

	#VolumeId=$(cinder create --display-name ${VolumePrefix}_${Volume}G_v${i} --availability-zone gpfs ${Volume} | grep " id "  | awk -F " " '{print $4}')
	VolumeId=$(cinder create --display-name ${VolumePrefix}_${Volume}G_v${i}  ${Volume} | grep " id "  | awk -F " " '{print $4}')
	nova volume-attach ${InstanceId} ${VolumeId}
	sleep 1
        nova start ${InstanceId}
     fi
	
done

#--flavor kvm.small \

	 #--security-groups  972729b8-d3bf-4b5a-b95f-51bcd2b156d5 \
         #--nic net-id=${mang_net} \



	#--user-data dockerfile \
