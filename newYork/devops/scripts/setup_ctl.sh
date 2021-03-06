#!/bin/bash
set -x

OLDHOST=ctl-n1
OLDHOSTIP=192.168.32.10
OLDVIP=ctl-vip
OLD_REGION=cess-cloud-sh1
OLD_PREFIX=ctl-

NEWHOST=ctl-n1
NEWHOSTIP=192.168.32.11
NEWVIP=ctl-vip
NEW_REGION=cess-cloud-sh1
NEW_PREFIX=ctl-

perl -pi -e "s/$OLDHOST/$NEWHOST/g" /etc/hostname
perl -pi -e "s/IPADDR=$OLDHOSTIP/IPADDR=$NEWHOSTIP/g" /etc/sysconfig/network-scripts/ifcfg-eth0
perl -pi -e "s/^osapi_compute_listen=0.0.0.0/osapi_compute_listen=$NEWHOSTIP/g" /etc/nova/*
perl -pi -e "s/^metadata_listen=0.0.0.0/metadata_listen=$NEWHOSTIP/g" /etc/nova/*
perl -pi -e "s/^osapi_volume_listen=0.0.0.0/osapi_volume_listen=$NEWHOSTIP/g" /etc/nova/*
perl -pi -e "s/^novncproxy_host=0.0.0.0/novncproxy_host=$NEWHOSTIP/g" /etc/nova/*
perl -pi -e "s/^novncproxy_base_url=http:\/\/0.0.0.0:6080\/vnc_auto.html/novncproxy_base_url=http:\/\/$NEWHOSTIP:6080\/vnc_auto.html/g" /etc/nova/*
perl -pi -e "s/^bind_host = 0.0.0.0/bind_host=$NEWHOSTIP/g" /etc/neutron/*
perl -pi -e "s/^bind_host = 0.0.0.0/bind_host=$NEWHOSTIP/g" /etc/glance/*
perl -pi -e "s/^registry_host = 0.0.0.0/registry_host=$NEWHOSTIP/g" /etc/glance/*
perl -pi -e "s/^admin_bind_host=0.0.0.0/admin_bind_host=$NEWHOSTIP/g" /etc/keystone/*
perl -pi -e "s/^public_bind_host=0.0.0.0/public_bind_host=$NEWHOSTIP/g" /etc/keystone/*
perl -pi -e "s/^osapi_volume_listen = 0.0.0.0/osapi_volume_listen=$NEWHOSTIP/g" /etc/cinder/*
perl -pi -e "s/^bind_host = 0.0.0.0/bind_host=$NEWHOSTIP/g" /etc/heat/*
perl -pi -e "s/^Listen $OLDHOST:35357/Listen $NEWHOST:35357/g" /etc/httpd/conf/ports.conf
perl -pi -e "s/^Listen $OLDHOST:5000/Listen $NEWHOST:5000/g" /etc/httpd/conf/ports.conf
perl -pi -e "s/^Listen $OLDHOST:80/Listen $NEWHOST:80/g" /etc/httpd/conf/ports.conf
perl -pi -e "s/$OLDHOST/$NEWHOST/g" /etc/httpd/conf/*
perl -pi -e "s/$OLDHOST/$NEWHOST/g" /etc/httpd/conf.d/*
perl -pi -e "s/$OLD_PREFIX/$NEW_PREFIX/g" /etc/haproxy/*
perl -pi -e "s/$OLD_PREFIX/$NEW_PREFIX/g" /etc/my.cnf.d/server.cnf

perl -pi -e "s/metadata_host=.*$/metadata_host=$NEWVIP/g" /etc/nova/nova.conf
perl -pi -e "s/nova_metadata_ip =.*$/nova_metadata_ip=$NEWVIP/g" /etc/neutron/metadata_agent.ini

perl -pi -e "s/^region_name.*$/region_name=$NEW_REGION/g" /etc/nova/nova.conf
perl -pi -e "s/^region_name.*$/region_name=$NEW_REGION/g" /etc/neutron/neutron.conf
perl -pi -e "s/^os_region_name.*$/os_region_name=$NEW_REGION/g" /etc/glance/*

# configure L3 HA
perl -pi -e "s/^l3_ha.*$/l3_ha=True/g" /etc/neutron/neutron.conf
perl -pi -e "s/^#dhcp_agents_per_network.*$/dhcp_agents_per_network=3/g" /etc/neutron/neutron.conf

#systemctl disable mariadb.service
# SET FOREIGN_KEY_CHECKS = 0;/SET FOREIGN_KEY_CHECKS = 1;
#mysqldump --opt -uroot -pdemopass keystone endpoint >keystone_endpoint.sql
#mysqldump --opt -uroot -pdemopass keystone region >keystone_region.sql
#perl -pi -e "s/controller_vip/$VIP/g" keystone_endpoint.sql
#perl -pi -e "s/PoC/$REGION/g" keystone_endpoint.sql
#perl -pi -e "s/PoC/$REGION/g" keystone_region.sql
#mysql -uroot -pdemopass keystone <keystone_endpoint.sql 
#mysql -uroot -pdemopass keystone <keystone_region.sql

