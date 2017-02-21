#!/bin/bash

set -x

OLDIP_PREFIX=192.168.191
OLD_REGION=NY-DevOps1

NEWIP_PREFIX=10.0.19
NEW_REGION=CRL-BZM

echo $HOSTNAME
echo $HOSTIP

#[root@ctl-n1 ~]# grep -rl "192.168.191" /etc/

perl -pi -e "s/$OLDIP_PREFIX/$NEWIP_PREFIX/g" /etc/sysconfig/iptables
perl -pi -e "s/$OLDIP_PREFIX/$NEWIP_PREFIX/g" /etc/sysconfig/iptables.save
perl -pi -e "s/$OLDIP_PREFIX/$NEWIP_PREFIX/g" /etc/nova/nova.conf
perl -pi -e "s/$OLDIP_PREFIX/$NEWIP_PREFIX/g" /etc/keystone/keystone.conf
perl -pi -e "s/$OLDIP_PREFIX/$NEWIP_PREFIX/g" /etc/glance/glance-api.conf
perl -pi -e "s/$OLDIP_PREFIX/$NEWIP_PREFIX/g" /etc/glance/glance-cache.conf
perl -pi -e "s/$OLDIP_PREFIX/$NEWIP_PREFIX/g" /etc/glance/glance-registry.conf
perl -pi -e "s/$OLDIP_PREFIX/$NEWIP_PREFIX/g" /etc/cinder/cinder.conf
perl -pi -e "s/$OLDIP_PREFIX/$NEWIP_PREFIX/g" /etc/neutron/metadata_agent.ini
perl -pi -e "s/$OLDIP_PREFIX/$NEWIP_PREFIX/g" /etc/heat/heat.conf
perl -pi -e "s/$OLDIP_PREFIX/$NEWIP_PREFIX/g" /etc/corosync/corosync.conf




#[root@ctl-n1 ~]# grep -rn "NY-DevOps1" .

perl -pi -e "s/$OLD_REGION/$NEW_REGION/g" /etc/nova/nova.conf
perl -pi -e "s/$OLD_REGION/$NEW_REGION/g" /etc/glance/glance-api.conf
perl -pi -e "s/$OLD_REGION/$NEW_REGION/g" /etc/glance/glance-cache.conf
perl -pi -e "s/$OLD_REGION/$NEW_REGION/g" /etc/neutron/neutron.conf
perl -pi -e "s/$OLD_REGION/$NEW_REGION/g" ./keystonerc_admin
perl -pi -e "s/$OLD_REGION/$NEW_REGION/g" ./openrc
