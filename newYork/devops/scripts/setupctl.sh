#!/bin/bash

host=poc-ctl1
hostip=10.0.0.132

echo $host

perl -pi -e "s/poc-ctl0/$host/g" /etc/hostname
perl -pi -e "s/IPADDR=10.0.0.131/IPADDR=$hostip/g" /etc/sysconfig/network-scripts/ifcfg-eth0
perl -pi -e "s/NODE_IP_ADDRESS=10.0.0.131/NODE_IP_ADDRESS=$hostip/g" /etc/rabbitmq/rabbitmq-env.conf

perl -pi -e "s/poc-ctl0/$host/g" /etc/httpd/conf/ports.conf
perl -pi -e "s/poc-ctl0/$host/g" /etc/nova/*
perl -pi -e "s/poc-ctl0/$host/g" /etc/neutron/*
perl -pi -e "s/poc-ctl0/$host/g" /etc/heat/*
perl -pi -e "s/poc-ctl0/$host/g" /etc/keystone/*
perl -pi -e "s/poc-ctl0/$host/g" /etc/glance/*
perl -pi -e "s/poc-ctl0/$host/g" /etc/cinder/*
perl -pi -e "s/poc-ctl0/$host/g" /etc/ironic/*
perl -pi -e "s/bind_address = poc-ctl0/bind_address = $host/g" /etc/my.cnf.d/server.cnf
perl -pi -e 's/poc-ctl0/$host/g' /etc/httpd/conf/*
perl -pi -e 's/poc-ctl0/$host/g' /etc/httpd/conf.d/*

mkdir -p /usr/lib/systemd/system/httpd.service.d/backup
mv /usr/lib/systemd/system/httpd.service.d/openstack-dashboard.conf /usr/lib/systemd/system/httpd.service.d/backup/

