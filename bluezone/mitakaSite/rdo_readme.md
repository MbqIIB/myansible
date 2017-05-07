# need change

```shell
/etc/xinetd.d/rsync
#change ctl-vip ctl-nx

service xinetd reload
service xinetd status
```

/etc/rsync.conf
ctl-vip to ctl-nX
service rsyncd restart
service rsyncd status

/etc/lvm/archive/cinder-volumes_00000-687247993.vg
/etc/lvm/backup/cinder-volumes
/etc/hosts
/etc/sysconfig/iptables
/etc/sysconfig/iptables.save
/etc/nova/nova.conf
/etc/swift/container-server.conf
/etc/swift/account-server.conf
/etc/swift/object-server.conf
/etc/swift/proxy-server.conf
/etc/keystone/keystone.conf
/etc/glance/glance-registry.conf
/etc/glance/glance-cache.conf
/etc/glance/glance-api.conf
/etc/cinder/cinder.conf
/etc/ironic/ironic.conf
/etc/neutron/api-paste.ini
/etc/neutron/neutron.conf
/etc/openstack-dashboard/local_settings
/etc/rsync.conf
/etc/heat/heat.conf
/etc/haproxy/haproxy.cfg


# change my.cf.d on 3 nodes
/etc/my.cnf.d/galera.cnf
#bind-address=0.0.0.0
bind-address=10.0.19.202

pcs cluster standby --all
pcs cluster unstandby --all


vim /etc/sysctl.conf
net.ipv4.ip_nonlocal_bind = 1

sysctl -p

pcs resource disable GLANCE_API-clone
pcs resource disable GLANCE_REGISTRY-clone
pcs resource
pcs resource enable GLANCE_API-clone
pcs resource enable GLANCE_REGISTRY-clone

please check all ctl node nfs dir
