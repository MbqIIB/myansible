#!/bin/bash

set -x

source /root/openrc

user="admin"

user="toddbloom@cn.ibm.com"


tenantid=$(keystone tenant-list | grep " ${user} " | awk -F ' ' '{print $2}')
username=$(keystone user-list | grep " ${user} " | awk -F ' ' '{print $2}')

instances=100
core=200
ram=20480000

#nova quota-show
nova quota-update \
    --instances ${instances} \
    --core ${core} \
    --floating-ips 1000 \
    --ram ${ram} \
    ${tenantid}

nova quota-update \
    --instances ${instances} \
    --core ${core} \
    --ram ${ram} \
    --floating-ips 1000 \
    --user ${username} ${tenantid}


#neutron quota-show
neutron quota-update \
            --router 1000 \
            --subnet 1000 \
            --network 1000 \
            --port 2000 \
            --floatingip 1000 \
            --security-group 1000 \
            --tenant-id ${tenantid}


cinder quota-defaults ${tenantid}
cinder quota-update \
    --gigabytes 20000 \
    --snapshots 1000 \
    --volumes 1000 \
    ${tenantid}

######### Check ##############
#nova quota-show
#neutron quota-show
#cinder quota-defaults ${tenantid}



