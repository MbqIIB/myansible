#!/bin/bash


#/var/log/neutron/ovs-cleanup.log
#2017-02-23 18:03:14.674 32195 INFO neutron.cmd.ovs_cleanup [-] Deleting port: qvobc51179c-ce
#2017-02-23 18:03:14.484 32195 INFO neutron.cmd.ovs_cleanup [-] Deleting port: qvo06d6da93-71

#2017-02-23 18:03:14.464 32195 INFO neutron.cmd.ovs_cleanup [-] Deleting port: qvo02cd5b48-2c
#2017-02-23 18:03:14.506 32195 INFO neutron.cmd.ovs_cleanup [-] Deleting port: qvo182e082e-2d
#2017-02-23 18:03:14.528 32195 INFO neutron.cmd.ovs_cleanup [-] Deleting port: qvo32e33979-a4
#2017-02-23 18:03:14.553 32195 INFO neutron.cmd.ovs_cleanup [-] Deleting port: qvo35fdaabe-d0
#2017-02-23 18:03:14.579 32195 INFO neutron.cmd.ovs_cleanup [-] Deleting port: qvo39fb3e2f-51
#2017-02-23 18:03:14.602 32195 INFO neutron.cmd.ovs_cleanup [-] Deleting port: qvo5888fa86-14
#2017-02-23 18:03:14.626 32195 INFO neutron.cmd.ovs_cleanup [-] Deleting port: qvo7f9bce97-9a
#2017-02-23 18:03:14.650 32195 INFO neutron.cmd.ovs_cleanup [-] Deleting port: qvo9ad32d70-35
#2017-02-23 18:03:14.698 32195 INFO neutron.cmd.ovs_cleanup [-] Deleting port: qvod1395cbb-79
#2017-02-23 18:03:14.722 32195 INFO neutron.cmd.ovs_cleanup [-] Deleting port: qvoe58da416-fb

set -x
#    e58da416-fb \
PortSuffix=( \
    02cd5b48-2c \
    182e082e-2d \
    32e33979-a4 \
    35fdaabe-d0 \
    39fb3e2f-51 \
    5888fa86-14 \
    7f9bce97-9a \
    9ad32d70-35 \
    d1395cbb-79 \
)
for port in ${PortSuffix[@]}
do
    ip link add qvo${port} type veth peer name qvb${port}
#    sleep 1
    brctl addif qbr${port} qvb${port}
#    sleep 1
    ovs-vsctl add-port br-int  qvo${port}
#    sleep 1
    ovs-vsctl set port qvo${port} tag=1
#    sleep 1
    ip link set qvo${port} up
#    sleep 1
    ip link set qvb${port} up 
#    sleep 1
done
