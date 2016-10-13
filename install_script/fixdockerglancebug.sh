#!/bin/bash
#sed -i '74 a\ \ \ \ \ \ \ \ \ \ \ \ key = key.lower()' /usr/lib/python2.7/dist-packages/glanceclient/v1/images.py
source /root/openrc
glance image-show a12e4bbd-e8a1-4c90-9e06-cfd16f46706c | grep name
