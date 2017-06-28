
modprobe ipmi_devintf
apt-get install ipmitool
ipmitool lan print 1


ansible compute-server-ubuntu-x86-2 -m shell -a "ipmitool lan print 1"
ansible compute-server-ubuntu-x86 -m shell -a "ipmitool lan print 1"



ansible compute-server-ubuntu-x86-2 -m shell -a "poweroff"


# CESS
iptables  -t nat -A POSTROUTING -s 192.168.0.0/18 ! -d 192.168.0.0/18 -j MASQUERADE
# DevOps
iptables  -t nat -A POSTROUTING -s 192.168.128.0/18 ! -d 192.168.128.0/18 -j MASQUERADE
