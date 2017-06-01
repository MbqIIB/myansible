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
[docker]
cpu_capping = True
set_fs_size = True
client_timeout = 3600
network_device_mtu = 1450
```


# plus

``` shell
# git clone git@github.ibm.com:dockeronpower/containerplus.git
wget http://ansible/containerplus.tar.gz

cd install/containerplus/
apt-get install  -y libpython-dev python-pip python-setuptools
pip install -r requirements.txt
./start-daemon

#edit /etc/rc.local

#check containerplus
containerplus=`netstat -natp|grep 8000`

if [ -z "$containerplus" ] ; then
    cd /home/install/containerplus
    ./start-daemon
fi

#check zfs mount for docker
modpro
dockerdir=`df | grep "/var/lib/docker"`

if [ -z "$dockerdir" ] ; then
    rm -rf /var/lib/docker/*
    zfs mount -a
    systemctl start docker
fi

```
# nova docker
```
git clone git@github.ibm.com:alchemy-containers/docker-infra-nova-docker.git                                                                                                                           
git co -b docker1.12 remotes/origin/docker1.12.0

```
