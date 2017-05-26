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

#set -x

pushd /tmp/
wget http://172.16.10.119/itcheck.20170522.tar.gz
tar xvf itcheck.20170522.tar.gz

cd itcheck

if [ -f /etc/system-release ];
then
    cat /etc/system-release

    mkdir /var/run/lock
    chmod 777 /var/run/lock/
    mkdir /var/lock/subsys

    rpm -ivh BESAgent-9.5.5.196-rhe7.ppc64le.rpm
else
    lsb_release -a
    dpkg -i BESAgent-9.5.5.196-ubuntu144.ppc64el.deb
fi

cp besclient.config /var/opt/BESClient/besclient.config
mkdir /etc/opt/BESClient
cp actionsite.afxm /etc/opt/BESClient/actionsite.afxm
cp TEM-Owner.txt  /

/etc/init.d/besclient start
ps -ef | grep BESClient

sleep 5
ls -l /var/opt/BESClient/__BESData/__Global/Logs/
#tail -f /var/opt/BESClient/__BESData/__Global/Logs/20170522.log

popd

cat /etc/rc.local
echo " vim /etc/rc.local "

rm -rf /tmp/itcheck*   /tmp/autoInstallTem.sh
