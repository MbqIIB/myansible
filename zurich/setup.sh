#!/bin/bash


# The script should be executed once in each compute node
# which supports FPGA and GPU attachment

mkdir -p /var/lib/nova/images/fpga
chown -R nova:nova /var/lib/nova/images/fpga

mkdir -p /var/lib/capi
chown -R nova:nova /var/lib/capi

mkdir -p /var/lib/sdaccel
chown -R nova:nova /var/lib/sdaccel

mkdir -p /var/lib/gpu
chown -R nova:nova /var/lib/gpu

echo -e "\nChanging the timeout setting in /etc/nova/nova.conf"
cp /etc/nova/nova.conf /etc/nova/nova.conf.bak.before.patch
sed -i "s/\(^[ ]*[^#]*timeout[ ]*=[ ]*\)[0-9]*[ ]*$/\1600/g" /etc/nova/nova.conf


echo -e "\nNova configuration is done. Please restart nova-compute service manually.\n"
echo -e "Please manually add one line in /etc/sudoers :"
echo -e "\tnova    ALL=(ALL)       NOPASSWD: ALL"

