#!/bin/bash

set -x
net_id=$(neutron net-list | awk '/baremetal-private/ {print $2}')
#MY_IMAGE_UUID=$(glance image-list | grep ubuntu-14.04.5-server-baremetal-ansiblekey | head -n 1 | awk '{print $2}')
#MY_IMAGE_UUID=$(glance image-list | grep ubuntu-14.04.5-server-baremetal-ansiblekey_v1 | head -n 1 | awk '{print $2}')
#MY_IMAGE_UUID=$(glance image-list | grep ubuntu-14.04.5-server-cloudimg-ppc64el | head -n 1 | awk '{print $2}')
#MY_IMAGE_UUID=$(glance image-list | grep ubuntu-14.04.5-server-cloudimg-ppc64el_v1 | head -n 1 | awk '{print $2}')
#MY_IMAGE_UUID=$(glance image-list | grep Ubuntu16.04.1-ppc64le-baremetal | head -n 1 | awk '{print $2}')
#MY_IMAGE_UUID=$(glance image-list | grep Ubuntu16.04.1-ppc64le-baremetal-ansiblekey | head -n 1 | awk '{print $2}')
MY_IMAGE_UUID=$(glance image-list | grep " Ubuntu16.04.1-ppc64le-baremetal-ansiblekey_v2 "| head -n 1 | awk '{print $2}')
#MY_IMAGE_UUID=$(glance image-list | grep xenial-server-cloudimg-ppc64el-disk1 | head -n 1 | awk '{print $2}')


nova list
#NodeName=fnode6_11
NodeName=bnode6_5
nova boot --flavor ppc64le-baremetal  \
          --image $MY_IMAGE_UUID \
          --nic net-id=$net_id  \
          --security-groups default  --key-name nova_key \
          ${NodeName}

sleep 2
nova list
