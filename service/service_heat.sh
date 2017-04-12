#!/bin/bash

set -x

ACTION=$1

systemctl $ACTION  openstack-heat-api-cfn.service
systemctl $ACTION  openstack-heat-api.service
systemctl $ACTION  openstack-heat-engine.service
