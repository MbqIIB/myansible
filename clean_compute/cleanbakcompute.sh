#!/bin/bash
set -x

DateTime=$(date +%Y%m%d_%H%M%S)
HNAME=$(hostname -s)

backdir=/tmp/backinfo/BackComputeInfo-${HNAME}-${DateTime}
mkdir -p ${backdir}

pushd ${backdir}

ifconfig -a > ifconfig-bak-${DateTime}.txt
iptables-save  > iptables-bak-${DateTime}.sav
ovs-vsctl show  > ovs-vsctl-bak-${DateTime}.txt
brctl show >  brctl-bak-${DateTime}.txt
route -n > route-bak-${DateTime}.txt


cp -r /etc/rc.local ./
cp -r /etc/nova  ./
cp -r /etc/neutron ./
cp -r /etc/network ./
cp -r /root/.ssh ./


popd

