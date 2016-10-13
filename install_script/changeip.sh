#!/bin/bash

sed -i "s/172.29.163.29/172.29.165.213/g" /etc/network/interfaces.d/eth2 
sed -i "s/172.29.163.30/172.29.165.214/g" /etc/network/interfaces.d/eth2
sed -i "s/172.29.163.31/172.29.165.215/g" /etc/network/interfaces.d/eth2
sed -i "s/172.29.163.32/172.29.165.216/g" /etc/network/interfaces.d/eth2
sed -i "s/172.29.163.33/172.29.165.217/g" /etc/network/interfaces.d/eth2
sed -i "s/172.29.163.34/172.29.165.218/g" /etc/network/interfaces.d/eth2
sed -i "s/172.29.163.35/172.29.165.219/g" /etc/network/interfaces.d/eth2
sed -i "s/172.29.163.36/172.29.165.220/g" /etc/network/interfaces.d/eth2
sed -i "s/172.29.163.37/172.29.165.221/g" /etc/network/interfaces.d/eth2
sed -i "s/172.29.163.38/172.29.165.222/g" /etc/network/interfaces.d/eth2
sed -i "s/172.29.163.39/172.29.165.223/g" /etc/network/interfaces.d/eth2
sed -i "s/172.29.163.40/172.29.165.224/g" /etc/network/interfaces.d/eth2
sed -i "s/172.29.163.41/172.29.165.225/g" /etc/network/interfaces.d/eth2
sed -i "s/172.29.163.42/172.29.165.226/g" /etc/network/interfaces.d/eth2
sed -i "s/172.29.163.43/172.29.165.227/g" /etc/network/interfaces.d/eth2
sed -i "s/172.29.163.44/172.29.165.228/g" /etc/network/interfaces.d/eth2
sed -i "s/172.29.163.45/172.29.165.229/g" /etc/network/interfaces.d/eth2
sed -i "s/172.29.163.46/172.29.165.230/g" /etc/network/interfaces.d/eth2
sed -i "s/172.29.163.47/172.29.165.231/g" /etc/network/interfaces.d/eth2
sed -i "s/172.29.163.48/172.29.165.232/g" /etc/network/interfaces.d/eth2

ifdown eth2;ifup eth2;
ifconfig eth2 | grep 172.29.16

sed -i "s/255.255.255.0/255.255.240.0/g"  /etc/network/interfaces.d/eth3
