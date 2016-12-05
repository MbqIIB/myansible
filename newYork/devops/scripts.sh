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

#perl -pi -e "s/$OLDHOST/$HOSTNAME/g" /etc/hostname
#perl -pi -e "s/IPADDR=$OLDHOSTIP/IPADDR=$HOSTIP/g" /etc/sysconfig/network-scripts/ifcfg-eth0

perl -pi -e "s/^network_vlan_ranges.*$/network_vlan_ranges=$VLAN_RANGE/g" /etc/neutron/plugin.ini
perl -pi -e "s/^network_vlan_ranges.*$/network_vlan_ranges=$VLAN_RANGE/g" /etc/neutron/plugins/ml2/ml2_conf.ini

perl -pi -e "s/NODE_IP_ADDRESS=$OLDHOSTIP/NODE_IP_ADDRESS=0.0.0.0/g" /etc/rabbitmq/rabbitmq-env.conf

perl -pi -e "s/metadata_host=.*$/metadata_host=$HOSTVIP/g" /etc/nova/nova.conf
perl -pi -e "s/nova_metadata_ip =.*$/nova_metadata_ip=$HOSTVIP/g" /etc/neutron/metadata_agent.ini

perl -pi -e "s/^region_name.*$/region_name=$REGION/g" /etc/nova/nova.conf
perl -pi -e "s/^region_name.*$/region_name=$REGION/g" /etc/neutron/neutron.conf
perl -pi -e "s/^os_region_name.*$/os_region_name=$REGION/g" /etc/glance/*

perl -pi -e "s/$OLDHOST/$HOSTNAME/g" /etc/httpd/conf/ports.conf
perl -pi -e "s/$OLDHOST/$HOSTNAME/g" /etc/nova/*
perl -pi -e "s/$OLDHOST/$HOSTNAME/g" /etc/neutron/*
perl -pi -e "s/$OLDHOST/$HOSTNAMEip/g" /etc/heat/*
perl -pi -e "s/$OLDHOST/$HOSTNAME/g" /etc/keystone/*
perl -pi -e "s/$OLDHOST/$HOSTNAME/g" /etc/glance/*
perl -pi -e "s/$OLDHOST/$HOSTNAME/g" /etc/cinder/*
perl -pi -e "s/$OLDHOST/$HOSTNAME/g" /etc/ironic/*
perl -pi -e "s/$OLDHOST/$HOSTNAME/g" /etc/httpd/conf/*
perl -pi -e "s/$OLDHOST/$HOSTNAME/g" /etc/httpd/conf.d/*
perl -pi -e "s/$OLDHOSTIP/$HOSTIP/g" /etc/heat/*
perl -pi -e "s/controller_vip/$VIP/g" /etc/haproxy/*
perl -pi -e "s/controller_vip/$VIP/g" /etc/httpd/conf.d/15-horizon_vhost.conf

perl -pi -e "s/poc-ctl/$HOST_PREFIX/g" /etc/haproxy/*
perl -pi -e "s/poc-ctl/$HOST_PREFIX/g" /etc/my.cnf.d/server.cnf
perl -pi -e "s/poc-ctl/$HOST_PREFIX/g" /etc/corosync/corosync.conf

# if the controller is ctl1-3, then enable this
#perl -pi -e "s/$HOST_PREFIX"0"/$HOST_PREFIX"3"/g" /etc/haproxy/*
#perl -pi -e "s/$HOST_PREFIX"0"/$HOST_PREFIX"3"/g" /etc/my.cnf.d/server.cnf
#perl -pi -e "s/$HOST_PREFIX"0"/$HOST_PREFIX"3"/g" /etc/corosync/corosync.conf

perl -pi -e "s/controller_vip/$VIP/g" /etc/nova/*
perl -pi -e "s/controller_vip/$VIP/g" /etc/glance/*
perl -pi -e "s/controller_vip/$VIP/g" /etc/heat/*
perl -pi -e "s/controller_vip/$VIP/g" /etc/neutron/*
perl -pi -e "s/controller_vip/$VIP/g" /etc/keystone/*
perl -pi -e "s/controller_vip/$VIP/g" /etc/cinder/*
perl -pi -e "s/controller_vip/$VIP/g" /etc/ironic/*
perl -pi -e "s/controller_vip/$VIP/g" /etc/openstack-dashboard/local_settings
perl -pi -e "s/controller_vip/$VIP/g" /etc/sysconfig/iptables
perl -pi -e "s/controller_vip/$VIP/g" /etc/sysconfig/iptables.save
perl -pi -e "s/controller_vip/$VIP/g" /root/keystonerc_admin
perl -pi -e "s/PoC/$REGION/g" /root/keystonerc_admin

systemctl disable mariadb.service

# configure L3 HA
perl -pi -e "s/^l3_ha.*$/l3_ha=True/g" /etc/neutron/neutron.conf
perl -pi -e "s/^#dhcp_agents_per_network.*$/dhcp_agents_per_network=3/g" /etc/neutron/neutron.conf



#update iptables manaully
#perl -pi -e "s/10.0.0.13/10.2.0.13/g" /etc/sysconfig/iptables
#perl -pi -e "s/10.0.0.13/10.2.0.13/g" /etc/sysconfig/iptables.save


#pcs cluster auth poc1-ctl0 poc1-ctl1 poc1-ctl2
hacluster/demopass
#pcs cluster start poc1-ctl0 poc1-ctl1 poc1-ctl2

# SET FOREIGN_KEY_CHECKS = 0;/SET FOREIGN_KEY_CHECKS = 1;
mysqldump --opt -uroot -pdemopass keystone endpoint >keystone_endpoint.sql
mysqldump --opt -uroot -pdemopass keystone region >keystone_region.sql
perl -pi -e "s/controller_vip/$VIP/g" keystone_endpoint.sql
perl -pi -e "s/PoC/$REGION/g" keystone_endpoint.sql
perl -pi -e "s/PoC/$REGION/g" keystone_region.sql
mysql -uroot -pdemopass keystone <keystone_endpoint.sql 
mysql -uroot -pdemopass keystone <keystone_region.sql

neutron agent-list|grep True|awk '{print $2}'|xargs -i neutron agent-delete {}
nova service-list|grep poc|awk '{print $2}'|xargs -i nova service-delete {}
