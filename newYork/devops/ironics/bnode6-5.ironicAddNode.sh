#!/bin/bash

set -x
IRONIC_NODE_IPMI_ADDRESS="192.168.33.65"
IRONIC_NODE_IPMI_USERNAME=ADMIN
IRONIC_NODE_IPMI_PASSWORD=c6j6Ptz6
NODE_MAC_ADDRESS="7c:fe:90:96:85:40"
MY_DEPLOY_VMLINUZ_UUID=`glance image-list | grep p8el-deploy-vmlinuz | awk '{print $2}'`
MY_DEPLOY_INITRD_UUID=`glance image-list | grep p8el-deploy-initrd | awk '{print $2}'`

NodeName="p8lebnode65"

IRONIC_NODE=`ironic node-create --driver pxe_ipmitool --name ${NodeName} \
                    -i ipmi_address=$IRONIC_NODE_IPMI_ADDRESS   \
                    -i ipmi_username=$IRONIC_NODE_IPMI_USERNAME \
                    -i ipmi_password=$IRONIC_NODE_IPMI_PASSWORD \
                    -i deploy_kernel=$MY_DEPLOY_VMLINUZ_UUID \
                    -i deploy_ramdisk=$MY_DEPLOY_INITRD_UUID\
                    -p memory_mb=32768 -p cpus=192 -p local_gb=300 -p cpu_arch=ppc64le \
                     | grep uuid | grep -v chassis_uuid | \
                     awk '{print $4}'`
 
ironic port-create -a $NODE_MAC_ADDRESS -n $IRONIC_NODE
# whole disk image, local boot
ironic node-update $IRONIC_NODE add properties/capabilities='boot_option:local'
 
