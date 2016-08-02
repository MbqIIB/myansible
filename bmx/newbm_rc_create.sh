#!/bin/bash
set -x


if [ ! $# == 1 ];then
    echo "Please usage : ./rc_create.sh  XXX.cfg"
    exit 1
fi

configfile=$1
echo "Done"
echo "${configfile}"

source  ${configfile}


net_id=2f758a57-4fee-4497-a054-384d33e3a0ae
ext_net=4c25836a-19b7-4972-ab54-ccb972713b13
mang_net=

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
    insname=${Prefix}-${nodename}-$(echo ${FlavorOption} | sed "s/\.//g")-n${i}
    InstanceId=$(nova boot \
         --flavor ${FlavorOption} \
         --image   ${ImageName} \
         --nic net-id=${net_id} \
         ${insname} | grep ' id '| awk -F ' ' '{print $4}')


    if [ $? != 0 ];then

        echo "nova error ................"
        exit 1
    fi
         sleep 5
     fip2=$(nova floating-ip-create ${ext_net} | grep pub-net1 | awk -F ' ' '{print $4}')
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

         #--availability-zone nova:${Node}  \
         #--flavor $(echo ${FlavorOption} | sed "s/\.//g") \
