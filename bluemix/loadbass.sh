#!/bin/bash

set -x


SUBNET_ID=f70a593e-c534-41ba-82c3-bdcf6297965f
TENANT_ID=542f1ffe06ba437aa58b9fe59c04c2c4

neutron lbaas-loadbalancer-create \
	--name HA_MMC_LB --tenant-id ${TENANT_ID} ${SUBNET_ID}

sleep 2
neutron lbaas-listener-create --tenant-id ${TENANT_ID} \
	--name mmc-lb-80 --loadbalancer HA_MMC_LB --protocol TCP --protocol-port 80

sleep 2
neutron lbaas-pool-create --tenant-id ${TENANT_ID} \
	--name lb-pool-mmc --listener mmc-lb-80 --loadbalancer HA_MMC_LB --lb-algorithm ROUND_ROBIN --protocol TCP

sleep 2

neutron lbaas-member-create --tenant-id ${TENANT_ID} \
	--subnet ${SUBNET_ID} --address 10.100.0.58 --protocol-port 80 lb-pool-mmc
sleep 2

neutron lbaas-member-create --tenant-id ${TENANT_ID} \
	--subnet ${SUBNET_ID} --address 10.100.0.123 --protocol-port 80 lb-pool-mmc
sleep 2

neutron lbaas-member-create --tenant-id ${TENANT_ID} \
	--subnet ${SUBNET_ID} --address 10.100.0.118 --protocol-port 80 lb-pool-mmc
sleep 2

neutron lbaas-healthmonitor-create --tenant-id ${TENANT_ID} \
	--name mmc-monitor --delay 5 --max-retries 2 --timeout 10 --type TCP --pool lb-pool-mmc 


