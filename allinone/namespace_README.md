
ref:
http://www.cnblogs.com/junneyang/p/5257288.html




ip link add qvo06d6da93-71 type veth peer name qvb06d6da93-71
brctl addif qbr06d6da93-71 qvb06d6da93-71
ovs-vsctl add-port br-int  qvo06d6da93-71 1
ovs-vsctl set port qvo06d6da93-71 tag=1
ip link set qvo06d6da93-71 up
ip link set qvb06d6da93-71 up 
