#!/bin/bash

set -x

source /root/openrc

user="admin"


tenantid=$(keystone tenant-list | grep ${user} | awk -F ' ' '{print $2}')
username=$(keystone user-list | grep ${user} | awk -F ' ' '{print $2}')

instances=10000
core=20000
ram=204800000

#nova quota-show
nova quota-update \
    --instances ${instances} \
    --core ${core} \
    --ram ${ram} \
    ${tenantid}

nova quota-update \
    --instances ${instances} \
    --core ${core} \
    --ram ${ram} \
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


#  cinder quota-defaults ${tenantid}
#  cinder quota-update \
#      --gigabytes 20000 \
#      --snapshots 1000 \
#      --volumes 1000 \
#      ${tenantid}

######### Check ##############
#nova quota-show
#neutron quota-show
#cinder quota-defaults ${tenantid}



