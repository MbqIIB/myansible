#!/bin/bash
set -x

if [ $# != 1 ]
then
echo "usage : service_restart.sh  status|restart|stop"
exit 1
fi

action=$1

echo "action = ${action}"


run()
{
service   nova-compute                       ${action}
service   neutron-openvswitch-agent   ${action}
}

run ${action}


