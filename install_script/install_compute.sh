#!/bin/bash
set -x

echo "setup environment"
echo "    StrictHostKeyChecking no" >>/etc/ssh/ssh_config

echo "setup apt repo"
apt-get -y install apt-transport-https ca-certificates ubuntu-cloud-keyring python-pip
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu trusty-updates/kilo main" > /etc/apt/sources.list.d/cloudarchive-kilo.list
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list
apt-get update

echo "install docker"
apt-get purge lxc-docker
apt-get -y install linux-image-extra-$(uname -r)
apt-get -y install apparmor
apt-get -y install docker-engine
service docker start
groupadd docker

echo "install nova"
apt-get -y install nova-compute sysfsutils
service nova-compute restart
rm -f /var/lib/nova/nova.sqlite

echo "install neutron"
echo "net.ipv4.conf.all.rp_filter=0" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.rp_filter=0" >> /etc/sysctl.conf
echo "net.bridge.bridge-nf-call-iptables=1" >> /etc/sysctl.conf
echo "net.bridge.bridge-nf-call-ip6tables=1" >> /etc/sysctl.conf
sysctl -p
apt-get -y install neutron-plugin-ml2 neutron-plugin-openvswitch-agent

echo "setup docker group"
usermod -aG docker neutron
usermod -aG docker nova

echo "install nova-docker"
mkdir -p /home/install
scp 192.168.33.2:/home/zhuchao/install/nova-docker-alchemy.tar.gz /home/install/
cd /home/install
tar xzf nova-docker-alchemy.tar.gz
cd nova-docker-alchemy/nova-docker/
pip install .
chmod a+rx -R /usr/local/lib/python2.7/dist-packages/


echo "configure nova"
mv /etc/nova/nova.conf /etc/nova/nova.conf.old
mv /etc/nova/nova-compute.conf /etc/nova/nova-compute.conf.old 
scp 192.168.33.114:/etc/nova/nova.conf /etc/nova/nova.conf
scp 192.168.33.114:/etc/nova/nova-compute.conf /etc/nova/nova-compute.conf
echo "[docker]" >>/etc/nova/nova.conf
echo "cpu_capping=true" >>/etc/nova/nova.conf
echo "[Filters]" >> /etc/nova/rootwrap.d/docker.filters
echo "ln: CommandFilter, /bin/ln, root" >> /etc/nova/rootwrap.d/docker.filters
echo "mv: CommandFilter, /bin/mv, root" >> /etc/nova/rootwrap.d/docker.filters
echo "cat: CommandFilter, /bin/cat, root" >> /etc/nova/rootwrap.d/docker.filters
echo "mount: CommandFilter, /usr/bin/mount, root" >> /etc/nova/rootwrap.d/docker.filters
echo "umount: CommandFilter, /usr/bin/umount, root" >> /etc/nova/rootwrap.d/docker.filters
echo "blkid: CommandFilter, /usr/sbin/blkid, root" >> /etc/nova/rootwrap.d/docker.filters
echo "mkfs: CommandFilter, /usr/sbin/mkfs, root" >> /etc/nova/rootwrap.d/docker.filters
echo "capi_flash.sh: CommandFilter, /usr/bin/capi_flash.sh, root" >> /etc/nova/rootwrap.d/docker.filters
chown -R nova:nova /etc/nova
service nova-compute restart

echo "configure neutron"
mv /etc/neutron/neutron.conf /etc/neutron/neutron.conf.old
mkdir -p /etc/neutron/plugins/openvswitch/
scp 192.168.33.114:/etc/neutron/neutron.conf /etc/neutron/
scp 192.168.33.114:/etc/neutron/plugins/openvswitch/ovs_neutron_plugin.ini /etc/neutron/plugins/openvswitch/.
local_ip=$(ifconfig | grep 192.168.33 | awk '{print $2}'|awk -F ":" '{print $2}')
sed -i "s/192.168.33.114/$local_ip/g" /etc/neutron/plugins/openvswitch/ovs_neutron_plugin.ini 
#mv /etc/init.d/neutron-plugin-openvswitch-agent /etc/init.d/neutron-plugin-openvswitch-agent.old
#scp 192.168.33.114:/etc/init.d/neutron-plugin-openvswitch-agent /etc/init.d/
#chmod +x /etc/init.d/neutron-plugin-openvswitch-agent 
sed -i "s/etc\/neutron\/plugins\/ml2\/ml2_conf.ini/etc\/neutron\/plugins\/openvswitch\/ovs_neutron_plugin.ini/g" /etc/init/neutron-plugin-openvswitch-agent.conf 
sed -i "s/^tunnel_type = gre/tunnel_type = /g" /etc/neutron/plugins/openvswitch/ovs_neutron_plugin.ini 
sed -i "s/^tunnel_id_ranges = 1:1000/tunnel_id_ranges = /g" /etc/neutron/plugins/openvswitch/ovs_neutron_plugin.ini
sed -i "s/^tunnel_bridge = br-tun/tunnel_bridge = /g" /etc/neutron/plugins/openvswitch/ovs_neutron_plugin.ini
sed -i "s/^tunnel_types = gre,vxlan/tunnel_types = /g" /etc/neutron/plugins/openvswitch/ovs_neutron_plugin.ini
chown -R neutron:neutron /etc/neutron
ovs-vsctl add-br br-eth1
ovs-vsctl add-port br-eth1 p2p1
service openvswitch-switch restart
sleep 3
service neutron-plugin-openvswitch-agent restart

