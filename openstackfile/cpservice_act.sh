#!/bin/sh

cd /etc/init.d
#echo $#

if [ $# != 1 ]
then
        echo "usage : service_restart.sh  status|restart|stop"
                exit 1
                fi

                action=$1

                echo "action = ${action}"


run()
{
#    ./qpidd ${action}
    /etc/init.d/openstack-ceilometer-compute ${action}
    /etc/init.d/openstack-nova-compute ${action}
    /etc/init.d/neutron-openvswitch-agent ${action}
}

run ${action}
