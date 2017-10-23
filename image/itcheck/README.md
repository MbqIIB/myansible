# tem
```shell

vim /var/opt/BESClient/__BESData/__Global/Logs/20170510.log

/etc/init.d/besclient stop

vim /var/opt/BESClient/besclient.config

/etc/init.d/besclient start

 tail -f /var/opt/BESClient/__BESData/__Global/Logs/20170510.log
```

# old change

```shell
/etc/init.d/besclient stop

vim /var/opt/BESClient/besclient.config

[Software\BigFix\EnterpriseClient\Settings\Client\__RelayServer1]
value = http://172.16.10.13:52311/bfmirror/downloads/

[Software\BigFix\EnterpriseClient\Settings\Client\__RelayServer2]
value = http://129.34.20.42:52311/bfmirror/downloads/

[Software\BigFix\EnterpriseClient\Settings\Client\__RelaySelect_Automatic]
value = 0

/etc/init.d/besclient start
```


# config ubuntu docker
``` shell

cd /tmp/
wget http://9.186.61.119/software/itcheck.20170522.tar.gz
wget http://172.16.10.119/software/itcheck.20170522.tar.gz
tar xvf itcheck.20170522.tar.gz
cd itcheck
dpkg -i BESAgent-9.5.5.196-ubuntu144.ppc64el.deb

rpm -ivh BESAgent-9.5.5.196-rhe7.ppc64le.rpm

mkdir /var/run/lock
chmod 777 /var/run/lock/
mkdir /var/lock/subsys

cp besclient.config /var/opt/BESClient/besclient.config
mkdir /etc/opt/BESClient
cp actionsite.afxm /etc/opt/BESClient/actionsite.afxm
cp TEM-Owner.txt  /
/etc/init.d/besclient start
ps -ef | grep BESClient
ls -l /var/opt/BESClient
ls -l /var/opt/BESClient/__BESData/__Global/Logs/
tree -f /var/opt/BESClient/__BESData/__Global/Logs/
tail -f /var/opt/BESClient/__BESData/__Global/Logs/20170726.log

# kvm
systemctl enable besclient.service
systemctl status besclient.service
systemctl start besclient.service

rm -rf /tmp/itcheck
history -c
history -w
```
# auto install
``` shell
cd /tmp
wget http://172.16.10.119/software/autoInstallTem.sh
bash autoInstallTem.sh

vim /etc/rc.local
/etc/init.d/besclient start &
history -c
history -w

```

# x86
``` shell
cd /tmp/
wget http://172.16.10.119/software/itcheck.20170522.tar.gz
wget http://9.186.61.119/software/itcheck.20170808.tar.gz
tar xvf itcheck.20170522.tar.gz
cd itcheck
dpkg -i BESAgent-9.5.5.196-ubuntu10.amd64.deb

rpm -ivh BESAgent-9.5.5.196-rhe6.x86_64.rpm
#chkconfig besclient on

cp besclient.config /var/opt/BESClient/besclient.config
mkdir /etc/opt/BESClient
cp actionsite.afxm /etc/opt/BESClient/actionsite.afxm
cp TEM-Owner.txt  /

systemctl enable besclient.service
systemctl status besclient.service
systemctl start besclient.service

/etc/init.d/besclient start
vim /var/opt/BESClient/besclient.config
tail -f /var/opt/BESClient/__BESData/__Global/Logs/20171016.log
```

# fixssh
```
grep -rn "Ciphers" /etc/ssh
grep -rn "hmac" /etc/ssh

# update /etc/ssh/ssh_config
    Ciphers aes128-ctr,aes192-ctr,aes256-ctr
    #MACs hmac-sha1,umac-64@openssh.com,hmac-ripemd160

service ssh restart
systemctl status sshd
systemctl restart sshd

glance  image-update --property image_type=image --is-public=true dd443da2-c5cb-4a7d-8ed4-465e52819fdb
glance  image-update --property image_type=image --is-public=true af012631-1ff0-4a91-8dde-8d605ea60c53
```

# repo

# enterprise
ln -s /gpfs/gpfs_enterprise/repositories/CentOS/7.3/ppc64le /var/www/html/CentOS7.3-ppc64le
ln -s /gpfs/gpfs_enterprise/repositories/RHEL7/7.3/ppc64le /var/www/html/rhel7.3-ppc64le
ln -s /gpfs/gpfs_enterprise/repositories/RHEL7/7.2/x86_64 /var/www/html/RHEL7.2-x86_64
ln -s /gpfs/gpfs_enterprise/repositories/CentOS/7.3/x86_64 /var/www/html/CentOS7.3-x86_64
ln -s /gpfs/gpfs_enterprise/repositories/CentOS/7.3/ppc64le /var/www/html/CentOS7.3-ppc64le
ln -s /gpfs/gpfs_enterprise/repositories/RHEL7/7.3/ppc64le /var/www/html/RHEL7.3-ppc64le
ln -s /gpfs/gpfs_enterprise/repositories/RHEL7/7.3/x86_64/ /var/www/html/RHEL7.3-x86_64

# community
ln -s /gpfs/iso/yumrepos/CentOS/7.3/ppc64le /var/www/html/CentOS7.3-ppc64le
wget http://172.16.10.12/imageclean/centos7.3-ppc64le.repo
