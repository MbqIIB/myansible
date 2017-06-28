``` shell
scp svp3:/etc/nova/nova.conf .
scp svp3:/etc/neutron/plugins/ml2/openvswitch_agent.ini .
scp svp3:/etc/neutron/neutron.conf .



MYIP=$(grep `hostname` /etc/hosts | grep "192.168" | awk -F  ' ' '{print $1}');sed -i "s/^my_ip.\+/my_ip=${MYIP}/g" /etc/nova/nova.conf
LOCALIP=$(grep `hostname` /etc/hosts | grep "10.0" | awk -F  ' ' '{print $1}');sed -i "s/^local_ip.\+/local_ip=${LOCALIP}/g" /etc/neutron/plugins/ml2/openvswitch_agent.ini


ansible install-server  -m shell -a "grep -nr "^my_ip" /etc/nova/"
ansible install-server  -m shell -a "grep -nr "^local_ip" /etc/neutron/"
ansible install-server  -m shell -a "/root/mitaka_servicerestart.sh start"



ansible install-server  -m shell -a "ppc64_cpu --smt=off"

ansible install-server  -m shell -a "apt install -y ipmitool;modprobe ipmi_devintf"
ansible install-server  -m shell -a "ipmitool lan print 1"


ipmitool -I lanplus -H 192.168.33.71 -U ADMIN -P admin power status

```


ansible install-server  -m shell -a "/root/mitaka_servicerestart.sh stop"
ansible install-server  -m shell -a "ovs-vsctl del-br br-int"
ansible install-server  -m shell -a "ovs-vsctl del-br br-tun"
ansible install-server  -m shell -a "/root/mitaka_servicerestart.sh start"



ansible install-server  -m shell -a "ifconfig br-int 0 up"
ansible install-server  -m shell -a "ifconfig br-tun 0 up"


ansible install-server  -m shell -a "route add  -net 10.10.64.0/18 gw 10.10.83.254"


x86:
route add  -net 10.10.64.0/18 gw 10.10.75.254  eth1




ansible install-server  -m shell -a "grep -nr "^my_ip" /etc/nova/nova.conf"
ansible install-server  -m shell -a "grep  -nr "^local_ip" /etc/neutron/plugins/ml2/openvswitch_agent.ini"

# check compute config
cat /etc/nova/nova.conf  | grep -v '^$'  | grep -v "^#"

# check compute kvm config
``` shell
ansible compute-server-ppc64le-kvm  -m shell -a "lscpu | grep 'CPU(s)' "
ansible install-server -m shell -a "grep -rn '^compute_driver' /etc/nova/nova.conf| grep -v docker
ansible compute-server-ppc64le-kvm -m shell -a "grep -rn '^compute_driver' /etc/nova/nova.conf"
ansible compute-server-ppc64le-kvm -m shell -a "/root/mitaka_servicerestart.sh restart"


ansible compute-server-ppc64le-docker -m shell -a "grep -rn '^compute_driver' /etc/nova/nova.conf"
ansible compute-server-ppc64le-docker -m shell -a "lscpu | grep 'CPU(s)' "
ansible compute-server-ppc64le-docker -m shell -a "ppc64_cpu --smt=on"
```


# check compute route
``` shell
ansible compute-server -m shell -a "route -n"
bnode6-3,bnode6-4, tnode6-14
route add  -net 10.10.64.0/18  gw  10.10.83.254
#ping 10.10.72.25
#ping 10.10.72.26
#ping 10.10.72.27
```

# heat stack-list -g
```
n1/n2/n3
vim /etc/heat/policy.json
#context_is_admin
"stacks:global_index": "rule:deny_everybody",
	to
"stacks:global_index": "rule:context_is_admin",
```

# End
