#!/bin/bash

hostname $1
echo "$1" > /etc/hostname
echo "LANG=en_US.utf-8" > /etc/environment
echo "LC_ALL=en_US.utf-8" > /etc/environment

systemctl disable firewalld
systemctl stop firewalld
systemctl disable NetworkManager
systemctl stop NetworkManager
systemctl enable network
systemctl start network


perl -pi -e 's/SELINUX=enforcing/SELINUX= permissive/g' /etc/selinux/config

ulimit -n 8192
echo 'ulimit -n 8192' >> /etc/profile

#yum install -y centos-release-openstack-mitaka
yum update -y
yum install -y openstack-packstack

mkdir -p $(pwd)/install
packstack --gen-answer-file=$(pwd)/install/answer.txt

cat id_rsa.pub > authorized_keys
