#!/bin/bash
set -x

echo "setup environment"
echo "    StrictHostKeyChecking no" >>/etc/ssh/ssh_config

echo "setup apt repo"
apt-get -y install apt-transport-https ca-certificates ubuntu-cloud-keyring python-pip
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu trusty-updates/kilo main" > /etc/apt/sources.list.d/cloudarchive-kilo.list
#echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list
apt-get update

echo "setup DNS"
echo "nameserver 8.8.8.8" > /etc/resolvconf/resolv.conf.d/base
echo "nameserver 8.8.4.4" >> /etc/resolvconf/resolv.conf.d/base
resolvconf -u

echo "install docker"
#apt-get purge lxc-docker
#apt-get -y install linux-image-extra-$(uname -r)
#apt-get -y install apparmor
#apt-get -y install docker-engine

apt-get -y install aufs-tools cgroup-lite git git-man liberror-perl patch
scp ansible:/root/docker.io_1.9.1~git20151210-18bfacb_ppc64el.deb /home/
dpkg -i /home/docker.io_1.9.1~git20151210-18bfacb_ppc64el.deb

service docker start
groupadd docker

echo "install docker.py"
#1 install docker-py
apt-get -y install libpython-dev python-pip python-setuptools unzip
pip install docker-py==1.7.2

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

echo "setup zfs file system"
apt-get install -y software-properties-common
add-apt-repository -y ppa:zfs-native/stable
apt-get update
apt-get -y install spl spl-dkms

mkdir -p /home/install

scp -r svf6:/home/install/packages /home/install/

pushd /home/install/packages

#dpkg -i zfs-dkms_0.6.5.7-1~trusty_ppc64el.deb
#dpkg -i zfsutils_0.6.5.7-1~trusty_ppc64el.deb
#然后把除了带有dbg的deb包之外的其它包挨着装一下，注意，上面两个包必须单独分别装

dpkg -i libnvpair1_0.6.5.7-1~trusty_ppc64el.deb \
        libuutil1_0.6.5.7-1~trusty_ppc64el.deb \
        libzfs2_0.6.5.7-1~trusty_ppc64el.deb \
        libzfs-dev_0.6.5.7-1~trusty_ppc64el.deb \
        libzpool2_0.6.5.7-1~trusty_ppc64el.deb \
        zfs-doc_0.6.5.7-1~trusty_ppc64el.deb

dpkg -i zfsutils_0.6.5.7-1~trusty_ppc64el.deb
dpkg -i zfs-initramfs_0.6.5.7-1~trusty_ppc64el.deb \
        zfs-zed_0.6.5.7-1~trusty_ppc64el.deb

dpkg -i zfs-dkms_0.6.5.7-1~trusty_ppc64el.deb


#装好之后，加载模块
modprobe spl
modprobe zfs

#然后看看，模块是否加载上
lsmod | grep spl
popd

#3. 配置zfs

#用空的硬盘创建docker
#zpool create -f zpool-docker /dev/sda
#然后用光成发给你的命令，把docker挂到zfs上面，记得修改/etc/default/docker, DOCKER_OPTS = "--storage-driver=zfs"

echo "configure docker with zfs support"
service docker stop
echo "DOCKER_OPTS=\"--storage-driver=zfs\"" >> /etc/default/docker
rm -rf /var/lib/docker

fdisk -l  > /tmp/disk.log 2>&1

syspart=`df -h|grep "/$"|awk '{print $1}' | cut -b -8`
DISKNAME=$(cat /tmp/disk.log | grep Disk | grep GB|grep -v $syspart|grep -v iden|awk '{print $2}'|cut -b -8)
echo "${DISKNAME}"
zpool create -f zpool-docker ${DISKNAME}
zfs create -o mountpoint=/var/lib/docker zpool-docker/docker
zfs list

service docker start

echo "install containerplus"
scp -r svf6:/home/install/containerplus-master /home/install

pushd /home/install/containerplus-master
pip install -r requirements.txt
 ./start-daemon
popd

echo "install nova-docker"
scp -r svf6:/home/install/nova-docker-alchemy/ /home/install

pushd /home/install/nova-docker-alchemy/nova-docker/
pip install ./

chmod a+rx -R /usr/local/lib/python2.7/dist-packages/
popd

cp /usr/lib/python2.7/dist-packages/nova/objects/compute_node.py /usr/lib/python2.7/dist-packages/nova/objects/compute_node.py.bak20160531
cp /usr/lib/python2.7/dist-packages/nova/compute/resource_tracker.py  /usr/lib/python2.7/dist-packages/nova/compute/resource_tracker.py.bak20160531
rm -rf /usr/lib/python2.7/dist-packages/nova/objects/compute_node.pyc
rm -rf /usr/lib/python2.7/dist-packages/nova/compute/resource_tracker.pyc
scp svf6:/usr/lib/python2.7/dist-packages/nova/objects/compute_node.py   /usr/lib/python2.7/dist-packages/nova/objects/compute_node.py
scp svf6:/usr/lib/python2.7/dist-packages/nova/compute/resource_tracker.py /usr/lib/python2.7/dist-packages/nova/compute/resource_tracker.py
scp svf6:/usr/lib/python2.7/dist-packages/nova/compute/capi_states.py     /usr/lib/python2.7/dist-packages/nova/compute/
scp svf6:/usr/lib/python2.7/dist-packages/nova/compute/sdaccel_states.py  /usr/lib/python2.7/dist-packages/nova/compute/
scp svf6:/usr/lib/python2.7/dist-packages/nova/compute/gpu_states.py      /usr/lib/python2.7/dist-packages/nova/compute/

echo "configure nova"
mv /etc/nova/nova.conf /etc/nova/nova.conf.old
mv /etc/nova/nova-compute.conf /etc/nova/nova-compute.conf.old 
scp 192.168.33.114:/etc/nova/nova.conf /etc/nova/nova.conf
scp 192.168.33.114:/etc/nova/nova-compute.conf /etc/nova/nova-compute.conf
echo "[docker]" >>/etc/nova/nova.conf
echo "cpu_capping=true" >>/etc/nova/nova.conf
echo "set_fs_size=true" >> /etc/nova/nova.conf
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

DATAPORT=`route -n|grep "10.0.43"|awk '{print $8}'`
ifconfig ${DATAPORT} 0 up
ovs-vsctl add-br br-eth1
ovs-vsctl add-port br-eth1 ${DATAPORT}
ifconfig br-eth1 0 up
ifconfig br-int 0 up

service openvswitch-switch restart
sleep 3
service neutron-plugin-openvswitch-agent restart

echo "optimize system"
echo "turn off swap"
swapoff -a
echo "Set processor mode to max performance"
apt-get -y install cpufrequtils
sed -i "s/^GOVERNOR\s*=\s*\"ondemand\"/GOVERNOR=\"performance\"/g" /etc/init.d/cpufrequtils
update-rc.d ondemand disable
/etc/init.d/cpufrequtils start



