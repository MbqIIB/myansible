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

net_id=0dc977d0-90ce-4055-aac4-cb4ee21bc461
ext_net=e8f9c9d8-4f39-478d-8687-5f8885b8da8a
mang_net=

echo "${Prefix}-${Node}-${FlavorOption}-${ImageName}"

fp=flavorlist.log
nova flavor-list --all --extra-specs  > $fp

grep ${FlavorOption} $fp
if [ $? != 0 ];then
        echo "Don't have flavor ${FlavorOption}"
        exit 1
fi
fid=$(grep " ${FlavorOption} " $fp | awk -F '|' '{print $2}')



#exit 0
for ((i=${Number_start};i<${Number_end};i++))
do
    nodename=$(echo ${Node} | sed "s/ent-//g" | sed "s/.ibm.com//g")
    insname=${Prefix}-${nodename}-$(echo ${FlavorOption} | sed "s/\.//g")-${DateTime}n${i}

    if [ "X${KeyName}" != "X" ];then
    InstanceId=$(nova boot \
         --flavor ${fid} \
        --key-name=${KeyName} \
         --image   ${ImageName} \
         --availability-zone nova:${Node}  \
         --meta  accelerator_type=gpu_pcie \
         --meta  gpu_num=1 \
         --nic net-id=${net_id} \
         ${insname} | grep ' id '| awk -F ' ' '{print $4}')
    else
    InstanceId=$(nova boot \
         --flavor ${fid} \
         --image   ${ImageName} \
         --meta  accelerator_type=gpu_pcie \
         --meta  gpu_num=1 \
         --availability-zone nova:${Node}  \
         --nic net-id=${net_id} \
         ${insname} | grep ' id '| awk -F ' ' '{print $4}')

    fi

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

         #--flavor $(echo ${FlavorOption} | sed "s/\.//g") \
         #--availability-zone nova:${Node}  \
