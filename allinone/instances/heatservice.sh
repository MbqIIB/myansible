#!/bin/bash
set -x
ACTIVE=$1
systemctl $ACTIVE openstack-heat-api.service
systemctl $ACTIVE openstack-heat-api-cfn.service
systemctl $ACTIVE openstack-heat-engine.service
