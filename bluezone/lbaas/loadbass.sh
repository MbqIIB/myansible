#!/bin/bash

set -x


#internal subnet
SUBNET_ID=1bbb948c-d7f6-433e-804d-ca04d274007f

TENANT_ID=43569612775b4366920316d3b4149e30

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
	--subnet ${SUBNET_ID} --address 10.71.2.59 --protocol-port 80 lb-pool-mmc
sleep 2

neutron lbaas-member-create --tenant-id ${TENANT_ID} \
	--subnet ${SUBNET_ID} --address 10.71.2.58 --protocol-port 80 lb-pool-mmc
sleep 2
#
#neutron lbaas-member-create --tenant-id ${TENANT_ID} \
#	--subnet ${SUBNET_ID} --address 10.100.0.118 --protocol-port 80 lb-pool-mmc
#sleep 2

neutron lbaas-healthmonitor-create --tenant-id ${TENANT_ID} \
	--name mmc-monitor --delay 5 --max-retries 2 --timeout 10 --type TCP --pool lb-pool-mmc 


