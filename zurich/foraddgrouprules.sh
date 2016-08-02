#!/bin/bash

set -x
source /root/openrc

function gettenants()
{
keystone tenant-list > alltenant.txt
cat alltenant.txt | grep -v "^\+" | grep -v " id " > filteralltenant.txt
}

#main

gettenants


alltenant=$(awk -F ' ' '{print $2}' filteralltenant.txt)

#exit 0

for  tenantid in ${alltenant[@]}
do
        echo "${tenantid}"
#       neutron security-group-list --tenant-id  ${tenantid}
#       sleep 1

        defaultid=$(neutron security-group-list --tenant-id  ${tenantid} | grep " default " | awk -F ' ' '{print $2}')

#        #add group
#       neutron security-group-rule-create --tenant-id ${tenantid} \
#       --direction ingress \
#       --protocol icmp \
#       --remote-ip-prefix 0.0.0.0/0 \
#       ${defaultid}
#       #sleep 1
#       neutron security-group-rule-create --tenant-id ${tenantid} \
#       --direction ingress \
#       --protocol tcp \
#       --port-range-min 22 \
#       --port-range-max 22 \
#       --remote-ip-prefix 0.0.0.0/0 \
#       ${defaultid}
#
#       #sleep 1
#       neutron security-group-rule-create --tenant-id ${tenantid} \
#       --direction ingress \
#       --protocol tcp \
#       --port-range-min 4200 \
#       --port-range-max 4200 \
#       --remote-ip-prefix 0.0.0.0/0 \
#       ${defaultid}
#
#        neutron security-group-rule-create --tenant-id ${tenantid} \
#       --direction ingress \
#       --protocol tcp \
#       --port-range-min 5900 \
#       --port-range-max 5999 \
#       --remote-ip-prefix 0.0.0.0/0 \
#       ${defaultid}
#
#
#        neutron security-group-rule-create --tenant-id ${tenantid} \
#        --direction ingress \
#        --protocol tcp \
#        --port-range-min 8888 \
#        --port-range-max 8888 \
#        --remote-ip-prefix 0.0.0.0/0 \
#        ${defaultid}
#
#        neutron security-group-rule-create --tenant-id ${tenantid} \
#        --direction ingress \
#        --protocol tcp \
#        --port-range-min 3306 \
#        --port-range-max 3306 \
#        --remote-ip-prefix 0.0.0.0/0 \
#        ${defaultid}


        neutron security-group-rule-create --tenant-id ${tenantid} \
        --direction ingress \
        --protocol tcp \
        --port-range-min 10050 \
        --port-range-max 10051 \
        --remote-ip-prefix 0.0.0.0/0 \
        ${defaultid}



        sleep 1
#       neutron security-group-list --tenant-id  ${tenantid}
done

