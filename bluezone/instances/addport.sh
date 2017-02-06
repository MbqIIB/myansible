#!/bin/bash

set -x



nova secgroup-list-rules default


nova secgroup-add-rule default icmp -1 -1 0.0.0.0/0
nova secgroup-add-rule default tcp 22 22 0.0.0.0/0
nova secgroup-add-rule default tcp 4200 4200 0.0.0.0/0



nova secgroup-list-rules default




#nova secgroup-add-rule default tcp 5901 5909 0.0.0.0/0
nova secgroup-add-rule default tcp 5901 5999 0.0.0.0/0
