#!/bin/bash

echo "Change keystone port from 5000 to 11000, 35357 to 11001"
perl -pi -e 's/35357/11001/g' /etc/keystone/*
perl -pi -e 's/5000/11000/g' /etc/keystone/*

echo "Change glance port from 9292 to 11002"
perl -pi -e 's/9292/11002/g' /etc/glance/*
perl -pi -e 's/5000/11000/g' /etc/glance/*
perl -pi -e 's/35357/11001/g' /etc/glance/*

echo "Change neutron port from 9696 to 11003"
perl -pi -e 's/9696/11003/g' /etc/neutron/*
perl -pi -e 's/5000/11000/g' /etc/neutron/*
perl -pi -e 's/35357/11001/g' /etc/neutron/*

echo "Change ceilometer port 8777 to 11004"
perl -pi -e 's/8777/11004/g' /etc/ceilometer/*
perl -pi -e 's/5000/11000/g' /etc/ceilometer/*
perl -pi -e 's/35357/11001/g' /etc/ceilometer/*

echo "Change nova port 8774 to 11005"
perl -pi -e 's/8774/11005/g' /etc/nova/*
perl -pi -e 's/5000/11000/g' /etc/nova/*
perl -pi -e 's/35357/11001/g' /etc/nova/*
perl -pi -e 's/9696/11003/g' /etc/nova/*
perl -pi -e 's/9292/11002/g' /etc/nova/*
perl -pi -e 's/6385/11009/g' /etc/nova/*

echo "Change cinder port 8776 to 11006"
perl -pi -e 's/8776/11006/g' /etc/cinder/*
perl -pi -e 's/5000/11000/g' /etc/cinder/*
perl -pi -e 's/35357/11001/g' /etc/cinder/*

echo "Change heat port 8004 to 11007"
perl -pi -e 's/8004/11007/g' /etc/heat/*
perl -pi -e 's/5000/11000/g' /etc/heat/*
perl -pi -e 's/35357/11001/g' /etc/heat/*

echo "Change heat-cfn port 8000 to 11008"
perl -pi -e 's/8000/11008/g' /etc/heat/*

echo "Change ironic port 6385 to 11009"
perl -pi -e 's/6385/11009/g' /etc/heat/*

