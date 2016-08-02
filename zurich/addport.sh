#!/bin/bash

set -x
nova secgroup-list-rules default

nova secgroup-add-rule default icmp -1 -1 0.0.0.0/0
nova secgroup-add-rule default tcp 22 22 0.0.0.0/0
nova secgroup-add-rule default tcp 4200 4200 0.0.0.0/0

nova secgroup-list-rules default


exit 0


nova secgroup-add-rule default tcp 80 80 0.0.0.0/0
nova secgroup-add-rule default tcp 5671 5671 0.0.0.0/0
nova secgroup-add-rule default tcp 5672 5672 0.0.0.0/0
nova secgroup-add-rule default tcp 4369 4369 0.0.0.0/0
nova secgroup-add-rule default tcp 15672 15672 0.0.0.0/0
nova secgroup-add-rule default tcp 1883 1883 0.0.0.0/0
nova secgroup-add-rule default tcp 8883 8883 0.0.0.0/0
nova secgroup-add-rule default tcp 11012 11012 0.0.0.0/0
nova secgroup-add-rule default tcp 6379 6379  0.0.0.0/0
nova secgroup-add-rule default tcp 4040 4040 0.0.0.0/0
nova secgroup-add-rule default tcp 50070 50070 0.0.0.0/0
nova secgroup-add-rule default tcp 9000 9000 0.0.0.0/0
nova secgroup-add-rule default tcp 9001 9001 0.0.0.0/0

nova secgroup-add-rule default tcp 27017 27017 0.0.0.0/0
nova secgroup-add-rule default tcp 8080 8080 0.0.0.0/0
nova secgroup-add-rule default tcp 8090 8090 0.0.0.0/0
nova secgroup-add-rule default tcp 9088 9088 0.0.0.0/0
nova secgroup-add-rule default tcp 12632 12632 0.0.0.0/0
nova secgroup-add-rule default tcp 9080 9080 0.0.0.0/0

nova secgroup-add-rule default tcp 9200 9200 0.0.0.0/0
nova secgroup-add-rule default tcp 9300 9300 0.0.0.0/0


nova secgroup-add-rule default tcp 1 65535 0.0.0.0/0

