#!/bin/bash

set -x

OLDIP_PREFIX=192.168.191
OLD_REGION=NY-DevOps1

NEWIP_PREFIX=9.4.241
NEW_REGION=Zurich2
NEW_DATAIP=10.13.0.205

echo $HOSTNAME
echo $HOSTIP

#[root@ctl-n1 ~]# grep -rl "192.168.191" /etc/

perl -pi -e "s/$OLDIP_PREFIX/$NEWIP_PREFIX/g" /etc/neutron/metadata_agent.ini
perl -pi -e "s/10.10.72.25/$NEW_DATAIP/g" /etc/neutron/plugins/ml2/openvswitch_agent.ini




#[root@ctl-n1 ~]# grep -rn "NY-DevOps1" .

perl -pi -e "s/$OLD_REGION/$NEW_REGION/g" /etc/neutron/neutron.conf
