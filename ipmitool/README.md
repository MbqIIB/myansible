
modprobe ipmi_devintf
apt-get install ipmitool
ipmitool lan print 1


ansible compute-server-ubuntu-x86-2 -m shell -a "ipmitool lan print 1"
ansible compute-server-ubuntu-x86 -m shell -a "ipmitool lan print 1"



ansible compute-server-ubuntu-x86-2 -m shell -a "poweroff"
