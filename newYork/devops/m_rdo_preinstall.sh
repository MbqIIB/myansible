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

rpm -ivh https://repos.fedorapeople.org/repos/openstack/openstack-mitaka/rdo-release-mitaka-6.noarch.rpm
rpm -ivh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm
#yum install -y https://rdoproject.org/repos/rdo-release.rpm
yum install -y centos-release-openstack-mitaka
yum update -y
yum install -y openstack-packstack

# now reboot the machine
#packstack --gen-answer-file=my_answers.txt
#packstack --answer-file my_answers.txt

