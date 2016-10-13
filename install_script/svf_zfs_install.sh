#!/bin/bash

ifconfig eth2 172.29.163.41/18 up
route add default gw 172.29.128.13 eth2
wget google.com

if [ $?  != 0 ];then
exit 1
fi


#1 install docker-py
apt-get -y install libpython-dev python-pip python-setuptools unzip
pip install docker-py==1.7.2  
 
#2.zfs
apt-get install -y software-properties-common
add-apt-repository -y ppa:zfs-native/stable
apt-get update
apt-get -y install spl spl-dkms
 
#从svf4上面拷贝安装包，/home/install/packages
scp -r svf4:/home/install/packages /home/install/

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
lsmod | grep zfs

popd 

#3. 配置zfs
 
#用空的硬盘创建docker
#zpool create -f zpool-docker /dev/sda
#然后用光成发给你的命令，把docker挂到zfs上面，记得修改/etc/default/docker, DOCKER_OPTS = "--storage-driver=zfs"
 
service  docker stop
echo "DOCKER_OPTS=\"--storage-driver=zfs\"" >> /etc/default/docker
rm -rf /var/lib/docker


fdisk -l  > /tmp/disk.log 2>&1
DISKNAME=$(cat /tmp/disk.log | grep Disk | grep doesn | awk -F ' ' '{print $2}')
echo "${DISKNAME}"
zpool create -f zpool-docker ${DISKNAME}
zfs create -o mountpoint=/var/lib/docker zpool-docker/docker
zfs list

service docker start


#4. 安装新的nova-docker
# 
#a) 从svf4拷贝nova-docker过去，/home/install/nova-docker-alchemy
#b) 卸载原来的nova-docker
#     pip uninstall nova-docker
#c) 安装新的nova-docker
#d) 更新nova.conf
#     在最末尾加上这个：
#    [docker]
#    cpu_capping=true
#    set_fs_size=true


pushd /home/install/nova-docker-alchemy/nova-docker/
pip uninstall -y nova-docker
popd
rm -rf /home/install/nova-docker-alchemy/
scp -r svf4:/home/install/nova-docker-alchemy/ /home/install

pushd /home/install/nova-docker-alchemy/nova-docker/
pip install ./
popd

echo "set_fs_size=true" >> /etc/nova/nova.conf

 
#5. 安装containerplus
#  拷贝svf4上面/home/install/containerplus-master
scp -r svf4:/home/install/containerplus-master /home/install
  
pushd /home/install/containerplus-master

pip install -r requirements.txt
 ./start-daemon

popd
 
#6. 重启nova-compute
 
service nova-compute stop
service nova-compute start
