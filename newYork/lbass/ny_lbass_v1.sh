#!/bin/bash
set -x
NameSuffix=BlueScan8081
SubnetID=f4250ae1-36c5-499c-8c38-151d8ec8dc2f
TENANT_ID=461ac8f4615746a59a88d66427448fdd
Port=8081
#Protocol=TCP
Protocol=HTTP
#LB_Method=ROUND_ROBIN
LB_Method=SOURCE_IP

#neutron lb-pool-create \
#    --tenant-id ${TENANT_ID} \
#    --name lb-${NameSuffix} \
#    --lb-method ${LB_Method} \
#    --protocol ${Protocol} \
#    --subnet-id ${SubnetID}
#
#sleep 5
#
#Port_ID=$(neutron lb-vip-create \
#                   --tenant-id ${TENANT_ID} \
#                   --name vip-${NameSuffix} \
#                   --protocol-port ${Port} \
#                   --protocol ${Protocol} \
#                   --subnet-id ${SubnetID} lb-${NameSuffix} | grep "^| port_id " | awk -F '|' '{print $3}')
#sleep 5

Port_ID=c1d0ffe4-f5af-4ff4-9ca2-f047879d2601

Address=( \
          10.0.45.70 \
          10.0.45.71 \
        )

for ip in ${Address[@]}
do
    echo $ip
    neutron lb-member-create \
        --tenant-id ${TENANT_ID} \
        --address $ip --protocol-port ${Port} lb-${NameSuffix}
    sleep 5
done

PublicID=32670b8e-e0eb-4cb9-8c58-10c779d3bb17

sleep 5
FloatingIP_ID=$(neutron floatingip-create ${PublicID}  --tenant-id ${TENANT_ID} | grep "^| id " | awk -F '|' '{print $3}')
sleep 5
neutron floatingip-associate  ${FloatingIP_ID} ${Port_ID}
