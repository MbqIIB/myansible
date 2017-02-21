#!/bin/bash


sed -i "s/^osapi_compute_workers.*$/osapi_compute_workers=4/g" /etc/nova/nova.conf
sed -i "s/^metadata_workers.*$/metadata_workers=4/g" /etc/nova/nova.conf
