#!/bin/bash
sed -i 's/^SELINUX=.\+$/SELINUX=permissive/g' /etc/selinux/config
setenforce 0
echo 'ulimit -n 8192' >> /etc/profile
echo "LANG=en_US.utf-8" >> /etc/environment
echo "LC_ALL=en_US.utf-8" >> /etc/environment

systemctl disable firewalld
systemctl stop firewalld
systemctl disable NetworkManager
systemctl stop NetworkManager
systemctl enable network
systemctl start network



yum install -y ntp
systemctl enable ntpd
systemctl start ntpd

