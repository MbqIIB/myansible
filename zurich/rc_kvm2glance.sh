#!/bin/bash

set -x

if [ ! $# == 1 ];then
    echo "Please usage : ./rc_kvm2glance.sh  XXX.cfg"
    exit 1
fi

configfile=$1
echo "${configfile}"
source  ${configfile}

#srcdir=/var/lib/glance
srcdir=`pwd`


glance image-create --name=${OS_name} \
                    --container-format=${OS_container_format} \
                    --disk-format=${OS_disk_format} \
                    --property architecture=${OS_architecture} \
                    --property accelerator_type=${OS_accelerator_type} \
                    --property hypervisor_type=${OS_hypervisor_type} \
                    --property hw_disk_bus=${OS_hw_disk_bus} \
                    --property hw_video_model=${OS_hw_video_model} \
                    --property os_type="${OS_os_type}" \
                    --property base_type=${OS_base_type} \
                    --property image_type=${OS_image_type} \
                    --property sys_type=${OS_sys_type} \
                    --property webshell=${OS_webshell} \
                    --visibility=${OS_is_public} \
                    --file  ${srcdir}/${OS_name}.${OS_disk_format}

                    #--is-public=${OS_is_public} \
                    #--protected=${OS_is_public} \
