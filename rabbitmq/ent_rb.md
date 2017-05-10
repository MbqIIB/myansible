

systemctl stop rabbitmq-server
systemctl disable rabbitmq-server



[root@ent-ctl0-x86 ~]# grep -rn "192.168.16.104:5671" /etc/
/etc/nova/nova.conf:638:#rabbit_hosts=192.168.16.104:5671,192.168.16.105:5671,192.168.16.106:5671
/etc/heat/heat.conf:1214:rabbit_hosts=192.168.16.104:5671,192.168.16.105:5671,192.168.16.106:5671
/etc/keystone/keystone.conf:631:#rabbit_hosts = 192.168.16.104:5671,192.168.16.105:5671,192.168.16.106:5671
/etc/glance/glance-registry.conf:292:rabbit_hosts=192.168.16.104:5671,192.168.16.105:5671,192.168.16.106:5671
/etc/glance/glance-api.conf:724:rabbit_hosts=192.168.16.104:5671,192.168.16.105:5671,192.168.16.106:5671
/etc/neutron/neutron.conf:372:rabbit_hosts=192.168.16.104:5671,192.168.16.105:5671,192.168.16.106:5671
/etc/cinder/cinder.conf:897:rabbit_hosts=192.168.16.105:5671,192.168.16.104:5671,192.168.16.106:5671
/etc/cinder/cinder.conf.diffbackend:897:rabbit_hosts=192.168.16.105:5671,192.168.16.104:5671,192.168.16.106:5671
/etc/cinder/cinder.conf.old:896:rabbit_hosts=192.168.16.104:5671,192.168.16.105:5671,192.168.16.106:5671
/etc/ceilometer/ceilometer.conf:86:rabbit_hosts = 192.168.16.104:5671,192.168.16.105:5671,192.168.16.106:5671






sed -i "s/^rabbit_hosts.\+$/rabbit_hosts=192.168.16.111:5671,192.168.16.112:5671,192.168.16.113:5671/g" /etc/nova/nova.conf
sed -i "s/^rabbit_hosts.\+$/rabbit_hosts=192.168.16.111:5671,192.168.16.112:5671,192.168.16.113:5671/g" /etc/keystone/keystone.conf
sed -i "s/^rabbit_hosts.\+$/rabbit_hosts=192.168.16.111:5671,192.168.16.112:5671,192.168.16.113:5671/g" /etc/heat/heat.conf
sed -i "s/^rabbit_hosts.\+$/rabbit_hosts=192.168.16.111:5671,192.168.16.112:5671,192.168.16.113:5671/g" /etc/glance/glance-registry.conf
sed -i "s/^rabbit_hosts.\+$/rabbit_hosts=192.168.16.111:5671,192.168.16.112:5671,192.168.16.113:5671/g" /etc/glance/glance-api.conf
sed -i "s/^rabbit_hosts.\+$/rabbit_hosts=192.168.16.111:5671,192.168.16.112:5671,192.168.16.113:5671/g" /etc/neutron/neutron.conf
sed -i "s/^rabbit_hosts.\+$/rabbit_hosts=192.168.16.111:5671,192.168.16.112:5671,192.168.16.113:5671/g" /etc/cinder/cinder.conf
sed -i "s/^rabbit_hosts.\+$/rabbit_hosts=192.168.16.111:5671,192.168.16.112:5671,192.168.16.113:5671/g" /etc/ceilometer/ceilometer.conf
sed -i "s/^rabbit_hosts.\+$/rabbit_hosts=192.168.16.111:5671,192.168.16.112:5671,192.168.16.113:5671/g" /etc/ironic/ironic.conf


sed -i "s/^rabbit_hosts.\+$/rabbit_hosts=192.168.16.111:5671,192.168.16.112:5671,192.168.16.113:5671/g" /etc/nova/nova.conf
sed -i "s/^rabbit_hosts.\+$/rabbit_hosts=192.168.16.111:5671,192.168.16.112:5671,192.168.16.113:5671/g" /etc/neutron/neutron.conf

/root/cpservice_act.sh stop
/root/cpservice_act.sh start

/root/p8servicerestart.sh stop
/root/p8servicerestart.sh start






sed -i "s/^rabbit_hosts.\+$/rabbit_hosts=192.168.16.112:5671,192.168.16.111:5671,192.168.16.113:5671/g" /etc/nova/nova.conf
sed -i "s/^rabbit_hosts.\+$/rabbit_hosts=192.168.16.112:5671,192.168.16.111:5671,192.168.16.113:5671/g" /etc/keystone/keystone.conf
sed -i "s/^rabbit_hosts.\+$/rabbit_hosts=192.168.16.112:5671,192.168.16.111:5671,192.168.16.113:5671/g" /etc/heat/heat.conf

sed -i "s/^rabbit_hosts.\+$/rabbit_hosts=192.168.16.113:5671,192.168.16.112:5671,192.168.16.111:5671/g" /etc/glance/glance-registry.conf
sed -i "s/^rabbit_hosts.\+$/rabbit_hosts=192.168.16.113:5671,192.168.16.112:5671,192.168.16.111:5671/g" /etc/glance/glance-api.conf

sed -i "s/^rabbit_hosts.\+$/rabbit_hosts=192.168.16.113:5671,192.168.16.112:5671,192.168.16.111:5671/g" /etc/neutron/neutron.conf
sed -i "s/^rabbit_hosts.\+$/rabbit_hosts=192.168.16.113:5671,192.168.16.112:5671,192.168.16.111:5671/g" /etc/cinder/cinder.conf
sed -i "s/^rabbit_hosts.\+$/rabbit_hosts=192.168.16.113:5671,192.168.16.112:5671,192.168.16.111:5671/g" /etc/ceilometer/ceilometer.conf


