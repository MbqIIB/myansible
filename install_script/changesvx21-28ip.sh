#!/bin/bash

sed -i "s/192.168.32.31/192.168.33.71/g" /etc/network/interfaces 
sed -i "s/192.168.32.32/192.168.33.72/g" /etc/network/interfaces
sed -i "s/192.168.32.33/192.168.33.73/g" /etc/network/interfaces
sed -i "s/192.168.32.34/192.168.33.74/g" /etc/network/interfaces
sed -i "s/192.168.32.35/192.168.33.75/g" /etc/network/interfaces
sed -i "s/192.168.32.36/192.168.33.76/g" /etc/network/interfaces
sed -i "s/192.168.32.37/192.168.33.77/g" /etc/network/interfaces
sed -i "s/192.168.32.38/192.168.33.78/g" /etc/network/interfaces

ifdown p1p1;ifup p1p1;
ifconfig p1p1 | grep 192.168

#sed -i "s/255.255.255.0/255.255.240.0/g"  /etc/network/interfaces.d/eth3
