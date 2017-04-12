#!/bin/bash

set -x

glance image-download \
        --file  HDS_base-p8rh4c16g100g-v1.qcow2 26043d9d-62ea-47a6-9d81-24da8cded82d

sleep 20

echo "Finish"

