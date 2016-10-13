#!/bin/bash

set -x

DATAPORT=`route -n|grep "10.0.0"|awk '{print $8}'`
ifconfig ${DATAPORT} 0 up
ovs-vsctl add-port br-eth1 ${DATAPORT} 

service openvswitch-switch restart
sleep 3
service neutron-plugin-openvswitch-agent restart


