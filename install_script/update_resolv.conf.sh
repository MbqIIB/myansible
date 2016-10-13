#!/bin/bash
echo "nameserver 8.8.8.8" > /etc/resolvconf/resolv.conf.d/base
echo "nameserver 8.8.8.8" > /etc/resolv.conf
