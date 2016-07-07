#!/bin/sh

#set -x 
COLLECTOR_IP=192.168.0.211
COLLECTOR_PORT=2055
TIMEOUT=60
BRIDGE=br-int

case "$1" in
	start)
            ovs-vsctl -- set Bridge $BRIDGE netflow=@nf \
                      -- --id=@nf create NetFlow targets=\"${COLLECTOR_IP}:${COLLECTOR_PORT}\"\
                               active-timeout=${TIMEOUT}
		;;

	stop)
            ovs-vsctl clear Bridge $BRIDGE netflow
		;;


	*)
		echo "Usage: $0 {start|stop|restart}"
		exit 1
		;;
esac
