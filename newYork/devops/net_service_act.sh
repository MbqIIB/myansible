#!/bin/bash
set -x
systemctl $1 neutron-dhcp-agent.service
systemctl $1 neutron-l3-agent.service
systemctl $1 neutron-metadata-agent.service
systemctl $1 neutron-openvswitch-agent.service
systemctl $1 neutron-lbaas-agent.service
#systemctl $1 neutron-lbaasv2-agent.service

systemctl $1 neutron-metering-agent.service
