#!/bin/bash
if [ $# != 1 ]
then
echo "usage : service_restart.sh  status|restart|stop"
exit 1
fi

action=$1

echo "action = ${action}"


run()
{
#	/etc/init.d/openstack-ceilometer-compute ${action}
#	/etc/init.d/openstack-nova-compute ${action}
#	/etc/init.d/neutron-openvswitch-agent ${action}
/sbin/initctl ${action}  nova-compute
/sbin/initctl ${action}  neutron-plugin-openvswitch-agent
}

run ${action}


