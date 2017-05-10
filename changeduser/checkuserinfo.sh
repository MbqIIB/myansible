#!/bin/bash

set -x
nova list

cinder list

nova floating-ip-list
neutron port-list

#nova secgroup-list-rules default
