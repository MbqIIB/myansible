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
wget http://172.16.10.119/itcheck.20170522.tar.gz
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
tail -f /var/opt/BESClient/__BESData/__Global/Logs/20170522.log

rm -rf /tmp/itcheck
history -c
history -w
```
# auto install
``` shell
cd /tmp
wget http://172.16.10.119/autoInstallTem.sh
bash autoInstallTem.sh

vim /etc/rc.local
/etc/init.d/besclient start &
history -c
history -w

```

# x86
``` shell
cd /tmp/
wget http://172.16.10.119/itcheck.20170522.tar.gz
tar xvf itcheck.20170522.tar.gz
cd itcheck
dpkg -i BESAgent-9.5.5.196-ubuntu10.amd64.deb
cp besclient.config /var/opt/BESClient/besclient.config
mkdir /etc/opt/BESClient
cp actionsite.afxm /etc/opt/BESClient/actionsite.afxm
cp TEM-Owner.txt  /
/etc/init.d/besclient start
vim /var/opt/BESClient/besclient.config
tail -f /var/opt/BESClient/__BESData/__Global/Logs/20170525.log
```




