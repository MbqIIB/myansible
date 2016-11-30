#!/bin/bash

set -x

OLDHOST=poc-ctl0
OLDHOSTIP=10.0.0.131

HOSTNAME=$(cat /etc/hostname)
HOSTIP=$(ifconfig eth0|grep mask|awk '{print $2}')
VIP=poc-ctl-vip
HOSTVIP=192.168.191.190
HOST_PREFIX=poc-ctl
REGION=NY-devops1
VLAN_RANGE=physnet1:2000:2020

echo $HOSTNAME
echo $HOSTIP



perl -pi -e "s/^network_vlan_ranges.*$/network_vlan_ranges=$VLAN_RANGE/g" /etc/neutron/plugin.ini
perl -pi -e "s/^network_vlan_ranges.*$/network_vlan_ranges=$VLAN_RANGE/g" /etc/neutron/plugins/ml2/ml2_conf.ini
perl -pi -e "s/nova_metadata_ip =.*$/nova_metadata_ip=$HOSTVIP/g" /etc/neutron/metadata_agent.ini
perl -pi -e "s/^region_name.*$/region_name=$REGION/g" /etc/neutron/neutron.conf
perl -pi -e "s/$OLDHOST/$HOSTNAME/g" /etc/neutron/*
perl -pi -e "s/controller_vip/$VIP/g" /etc/neutron/*
perl -pi -e "s/^l3_ha.*$/l3_ha=True/g" /etc/neutron/neutron.conf
perl -pi -e "s/^#dhcp_agents_per_network.*$/dhcp_agents_per_network=3/g" /etc/neutron/neutron.conf
#neutron agent-list|grep True|awk '{print $2}'|xargs -i neutron agent-delete {}
