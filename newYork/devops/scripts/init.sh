#!/bin/bash
host=$(hostname)
echo $host
perl -pi -e "s/^osapi_compute_listen=0.0.0.0/osapi_compute_listen=${host}/g" /etc/nova/*
perl -pi -e "s/^metadata_listen=0.0.0.0/metadata_listen=${host}/g" /etc/nova/*
perl -pi -e "s/^osapi_volume_listen=0.0.0.0/osapi_volume_listen=${host}/g" /etc/nova/*
perl -pi -e "s/^novncproxy_host=0.0.0.0/novncproxy_host=${host}/g" /etc/nova/*
perl -pi -e "s/^novncproxy_base_url=http:\/\/0.0.0.0:6080\/vnc_auto.html/novncproxy_base_url=http:\/\/${host}:6080\/vnc_auto.html/g" /etc/nova/*


perl -pi -e "s/^bind_host = 0.0.0.0/bind_host=${host}/g" /etc/neutron/*
perl -pi -e "s/^bind_host = 0.0.0.0/bind_host=${host}/g" /etc/glance/*
perl -pi -e "s/^registry_host = 0.0.0.0/registry_host=${host}/g" /etc/glance/*


perl -pi -e "s/^admin_bind_host=0.0.0.0/admin_bind_host=${host}/g" /etc/keystone/*
perl -pi -e "s/^public_bind_host=0.0.0.0/public_bind_host=${host}/g" /etc/keystone/*


perl -pi -e "s/^osapi_volume_listen = 0.0.0.0/osapi_volume_listen=${host}/g" /etc/cinder/*

perl -pi -e "s/^bind_host = 0.0.0.0/bind_host=${host}/g" /etc/heat/*
perl -pi -e "s/^host_ip=0.0.0.0/host_ip=${host}/g" /etc/ironic/*


perl -pi -e "s/^Listen 35357/Listen ${host}:35357/g" /etc/httpd/conf/ports.conf 
perl -pi -e "s/^Listen 5000/Listen ${host}:5000/g" /etc/httpd/conf/ports.conf 

perl -pi -e "s/bind-address=0.0.0.0/bind-address=$host/g" /etc/my.cnf.d/*
perl -pi -e "s/bind-address = 0.0.0.0/bind-address=$host/g" /etc/my.cnf.d/*

# please note the password of hacluster is demopass


