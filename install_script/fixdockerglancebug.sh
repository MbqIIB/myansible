#!/bin/bash
sed -i '74 a\ \ \ \ \ \ \ \ \ \ \ \ key = key.lower()' /usr/lib/python2.7/dist-packages/glanceclient/v1/images.py
sed -i "s/^    VERSION = '1.2'/    VERSION = '1.1'/g"   /usr/lib/python2.7/dist-packages/nova/objects/pci_device.py
source /root/openrc
glance image-show a12e4bbd-e8a1-4c90-9e06-cfd16f46706c | grep name


# Centos kilo
#sed -i '75 a\ \ \ \ \ \ \ \ \ \ \ \ key = key.lower()' /usr/lib/python2.7/site-packages/glanceclient/v1/images.py
