#!/bin/bash
set -x

DateTime=$(date +%Y%m%d_%H%M%S)

backdir=/home/backinfo/BackComputeInfo-${DateTime}
mkdir -p ${backdir}

pushd ${backdir}

ifconfig -a > ifconfig-bak-${DateTime}.txt
iptables-save  > iptables-bak-${DateTime}.sav
ovs-vsctl show  > ovs-vsctl-bak-${DateTime}.txt
brctl show >  brctl-bak-${DateTime}.txt
route -n > route-bak-${DateTime}.txt


popd

