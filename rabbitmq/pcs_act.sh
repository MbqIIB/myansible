#!/bin/bash

set -x
ACTION=$1
#ACTION=disable
#ACTION=enable
#ACTION=cleanup

function nova()
{
pcs resource $ACTION NOVA_API-clone
pcs resource $ACTION NOVA_CERT-clone
pcs resource $ACTION NOVA_CONDUCTOR-clone
pcs resource $ACTION NOVA_CONSOLE-clone
pcs resource $ACTION NOVA_CONSOLEAUTH-clone
pcs resource $ACTION NOVA_NOVNCPROXY-clone
pcs resource $ACTION NOVA_SCHEDULER-clone
}

function rabbit()
{
pcs resource $ACTION RABBITMQ-clone [RABBITMQ]
}

function keystone()
{
pcs resource $ACTION KEYSTONE-clone [KEYSTONE]
}

function glance()
{
pcs resource $ACTION GLANCE_API-clone [GLANCE_API]
pcs resource $ACTION GLANCE_REGISTRY-clone [GLANCE_REGISTRY]
}

function neutron()
{
pcs resource $ACTION NEUTRON_SERVER-clone [NEUTRON_SERVER]
}

function cinder()
{
pcs resource $ACTION CINDER_API-clone [CINDER_API]
pcs resource $ACTION CINDER_SCHEDULER-clone [CINDER_SCHEDULER]
pcs resource $ACTION CINDER_VOLUME-clone [CINDER_VOLUME]
}

function heat()
{
pcs resource $ACTION HEAT_API-clone [HEAT_API]
pcs resource $ACTION HEAT_ENGINE-clone [HEAT_ENGINE]
}



function show()
{

pcs resource

}
#main

#show

#rabbit
#keystone
#nova
glance
neutron
cinder
heat



