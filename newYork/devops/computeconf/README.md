
scp svp3:/etc/nova/nova.conf .
scp svp3:/etc/neutron/plugins/ml2/openvswitch_agent.ini .
scp svp3:/etc/neutron/neutron.conf .



MYIP=$(grep `hostname` /etc/hosts | grep "192.168" | awk -F  ' ' '{print $1}');sed -i "s/^my_ip.\+/my_ip=${MYIP}/g" /etc/nova/nova.conf
LOCALIP=$(grep `hostname` /etc/hosts | grep "10.0" | awk -F  ' ' '{print $1}');sed -i "s/^local_ip.\+/local_ip=${LOCALIP}/g" /etc/neutron/plugins/ml2/openvswitch_agent.ini


ansible install-server  -m shell -a "grep -nr "^my_ip" /etc/nova/"
ansible install-server  -m shell -a "grep -nr "^local_ip" /etc/neutron/"
ansible install-server  -m shell -a "/root/mitaka_servicerestart.sh start"
