#!/usr/bin/env bash
set -x

INT_IF=eth1
EXT_NET_NAME="management"

source /root/openrc
if [ x"$1" == x ] ; then
#	VLAN_ID=`neutron net-show ${EXT_NET_NAME}|grep provider:segmentation_id |awk '{print $4}'`
	VLAN_ID=1200
	echo VLAN_ID=${VLAN_ID}
fi


echo ip link delete ${EXT_NET_NAME}-INT
ip link delete ${EXT_NET_NAME}-INT 

echo brctl delif br-management ${EXT_NET_NAME}-EXT
brctl delif br-management ${EXT_NET_NAME}-EXT
echo ovs-vsctl del-port br-$INT_IF ${EXT_NET_NAME}-INT
ovs-vsctl del-port br-$INT_IF ${EXT_NET_NAME}-INT

if [ x"$1" != x ] ; then
    echo "Clean only. Exiting."
    exit 0
fi

sleep 5
    
echo ip link add name ${EXT_NET_NAME}-INT type veth peer name ${EXT_NET_NAME}-EXT
ip link add name ${EXT_NET_NAME}-INT type veth peer name ${EXT_NET_NAME}-EXT

echo ifconfig ${EXT_NET_NAME}-INT up
ifconfig ${EXT_NET_NAME}-INT up
echo ifconfig ${EXT_NET_NAME}-EXT up
ifconfig ${EXT_NET_NAME}-EXT up

echo brctl addif br-management ${EXT_NET_NAME}-EXT
brctl addif br-management ${EXT_NET_NAME}-EXT
echo ovs-vsctl add-port br-$INT_IF ${EXT_NET_NAME}-INT tag=${VLAN_ID}
ovs-vsctl add-port br-$INT_IF ${EXT_NET_NAME}-INT tag=${VLAN_ID}

