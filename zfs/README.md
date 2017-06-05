# install zfs in ubuntu16.04

``` shell
apt-get install  -y git system-storage-manager
apt install zfs
zfs list
lsmod  | grep zfs
ssm list
service docker stop
rm /var/lib/docker/* -rf
ls /var/lib/docker/

zpool create -f zpool-docker -m /var/lib/docker /dev/sdb

zfs list
vim /etc/docker/daemon.json

{
  "storage-driver": "zfs"
}


service docker start
docker info
/root/mitaka_servicerestart.sh restart

```

# nova.conf

``` shell
vim /etc/nova/nova.conf
[docker]
cpu_capping = True
set_fs_size = True
client_timeout = 3600
network_device_mtu = 1450
```


# plus

``` shell
cd /home/install
# git clone git@github.ibm.com:dockeronpower/containerplus.git
wget http://ansible/containerplus.tar.gz

tar xvf containerplus.tar.gz
cd containerplus/
apt-get install  -y libpython-dev python-pip python-setuptools
pip install -r requirements.txt
./start-daemon

vim /etc/rc.local

##########
ifconfig br-int 0 up
ifconfig br-tun 0 up

####### Add For ZFS ###
#check containerplus
containerplus=`netstat -natp|grep 8000`

if [ -z "$containerplus" ] ; then
    cd /home/install/containerplus
    ./start-daemon
fi

#check zfs mount for docker
modprobe zfs
dockerdir=`df | grep "/var/lib/docker"`

if [ -z "$dockerdir" ] ; then
    rm -rf /var/lib/docker/*
    zfs mount -a
    systemctl start docker
fi
##########

```
# nova docker
```
git clone git@github.ibm.com:alchemy-containers/docker-infra-nova-docker.git                                                                                                                           
git co -b docker1.12 remotes/origin/docker1.12.0

```

# install nova docker
```
cd /home/install
wget http://172.31.252.53/IaaS-nova-docker.tar.gz
tar xvf IaaS-nova-docker.tar.gz 
cd IaaS-nova-docker/
pip install .
/root/mitaka_servicerestart.sh restart
```
