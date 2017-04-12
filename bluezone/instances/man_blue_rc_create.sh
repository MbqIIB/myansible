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

#net_id=0fba9e89-f3c1-418e-9b86-a96ca3fc2274
#ext_net=a771fe2b-bb21-4d5c-b13b-ab8b98aee8c4
#mang_net=f1386742-2558-4c19-bf7d-06f78012d74d


net_id=6903b280-3140-4cc7-93c3-8c5bcdd2b6f4
ext_net=78b71d0a-760d-4c90-a3ad-45af5e16b732
mang_net=35974342-cfe7-45bb-b81f-b9ea53a6ab91


echo "${Prefix}-${Node}-${FlavorOption}-${ImageName}"


nova flavor-list | grep ${FlavorOption}
if [ $? != 0 ];then
	echo "Don't have flavor ${FlavorOption}"
	exit 1
fi



#exit 0
for ((i=0;i<${Number};i++))
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
     fip2=$(nova floating-ip-create ext_net | grep ext_net | awk -F ' ' '{print $4}')
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

	VolumeId=$(cinder create --display-name ${VolumePrefix}_${Volume}G_v${i} --availability-zone gpfs ${Volume} | grep " id "  | awk -F " " '{print $4}')
	nova volume-attach ${InstanceId} ${VolumeId}
	sleep 1
        nova start ${InstanceId}
     fi
	
done

#--flavor kvm.small \

	 #--security-groups  972729b8-d3bf-4b5a-b95f-51bcd2b156d5 \
         #--nic net-id=${mang_net} \



