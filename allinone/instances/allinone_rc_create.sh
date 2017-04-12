#!/bin/bash
set -x

DateTime=$(date +%Y%m%d_%H%M%S)

if [ ! $# == 1 ];then
    echo "Please usage : ./rc_create.sh  XXX.cfg"
    exit 1
fi

configfile=$1
echo "Done"
echo "${configfile}"

source  ${configfile}


#net_id=4cf20833-94ef-4a9f-afb5-4753485deea9
#ext_net=431c4194-409e-410d-9e06-9712108b9a24
net_id=690a6f71-c7e1-423e-9c95-cf5ca2440b8c
ext_net=f8f5bdd4-78d3-4f2d-87d8-f67526e02ddf
mang_net=

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
    insname=${Prefix}-${nodename}-$(echo ${FlavorOption} | sed "s/\.//g")-n${i}-${DateTime}
    InstanceId=$(nova boot \
         --flavor ${FlavorOption} \
         --image   ${ImageName} \
         --availability-zone nova:${Node}  \
         --nic net-id=${net_id} \
         ${insname} | grep ' id '| awk -F ' ' '{print $4}')


    if [ $? != 0 ];then

        echo "nova error ................"
        exit 1
    fi
         sleep 5
     fip2=$(nova floating-ip-create ${ext_net} | grep "public" | awk -F ' ' '{print $4}')
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

         #--flavor $(echo ${FlavorOption} | sed "s/\.//g") \
