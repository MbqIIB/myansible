#!/bin/bash - 
#===============================================================================
#
#          FILE: autoInstallTem.sh
# 
#         USAGE: ./autoInstallTem.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 05/22/2017 05:53:04 PM CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

set -x

if [ -f /var/opt/BESClient/besclient.config ];then
    echo "besclient.config is exist"
    exit 1
fi

pushd /tmp/
#wget http://172.16.10.119/software/itcheck.20170522.tar.gz
#tar xvf itcheck.20170522.tar.gz
wget http://172.16.10.119/software/itcheck.20170808.tar.gz
tar xvf itcheck.20170808.tar.gz

cd itcheck

if [ -f /etc/system-release ];
then
    cat /etc/system-release

    mkdir /var/run/lock
    chmod 777 /var/run/lock/
    mkdir /var/lock/subsys

    lscpu | grep "Architecture" | grep "x86_64"
    if [ $? != 0 ];then
        #rpm -ivh BESAgent-9.5.5.196-rhe7.ppc64le.rpm
        rpm -ivh BESAgent-9.5.6.63-rhe7.ppc64le.rpm
    else
        rpm -ivh BESAgent-9.5.5.196-rhe6.x86_64.rpm
    fi


    #rpm -ivh  BESAgent-9.5.6.63-rhe5.ppc64.rpm
    systemctl enable besclient
    systemctl start besclient
    systemctl status besclient

else
    lsb_release -a
    lscpu | grep "Architecture" | grep "x86_64"
    if [ $? != 0 ];then
        dpkg -i BESAgent-9.5.5.196-ubuntu144.ppc64el.deb
    else
        dpkg -i BESAgent-9.5.5.196-ubuntu10.amd64.deb
    fi
fi

cp besclient.config /var/opt/BESClient/besclient.config
mkdir /etc/opt/BESClient
cp actionsite.afxm /etc/opt/BESClient/actionsite.afxm
cp TEM-Owner.txt  /

/etc/init.d/besclient start
ps -ef | grep BESClient

sleep 5
ls -l /var/opt/BESClient/__BESData/__Global/Logs/
DATE=$(date +'%Y%m%d')
#tail -f /var/opt/BESClient/__BESData/__Global/Logs/${DATE}.log

popd

cat /etc/rc.local
echo " vim /etc/rc.local "

rm -rf /tmp/itcheck*   /tmp/autoInstallTem.sh
