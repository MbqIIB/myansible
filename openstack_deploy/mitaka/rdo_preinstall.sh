#!/bin/bash
set -x

perl -pi -e 's/SELINUX=enforcing/SELINUX= permissive/g' /etc/selinux/config
echo 'ulimit -n 8192' >> /etc/profile
echo "LANG=en_US.utf-8" >> /etc/environment
echo "LC_ALL=en_US.utf-8" >> /etc/environment

systemctl disable firewalld
systemctl stop firewalld
systemctl disable NetworkManager
systemctl stop NetworkManager
systemctl enable network
systemctl start network

yum install -y https://rdoproject.org/repos/rdo-release.rpm
yum install -y centos-release-openstack-mitaka
yum update -y
yum install -y openstack-packstack

# now reboot the machine
#packstack --gen-answer-file=my_answers.txt
#packstack --answer-file my_answers.txt

