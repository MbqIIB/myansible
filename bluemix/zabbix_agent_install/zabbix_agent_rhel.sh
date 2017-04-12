#!/bin/bash
#install zabbix agent
#add zabbix user
yum install -y gcc gcc-c++ cpp libstdc++ iptables-services
groupadd  zabbix
useradd  -g zabbix -s /sbin/nologin -M zabbix
#install zabbix_agent
ZABBIXDIR=/tmp/zabbix_agent_install/
tar zxvf $ZABBIXDIR/zabbix-3.0.2.tar.gz -C /tmp/zabbix_agent_install/
cd $ZABBIXDIR/zabbix-3.0.2 && ./configure --prefix=/usr/local/zabbix --enable-agent
echo "Begining make........................"
make && make install
cd ..
#add service port and cfg start script
echo 'zabbix-agent 10050/tcp #Zabbix Agent'>>/etc/services
echo 'zabbix-agnet 10050/udp #Zabbix Agent'>>/etc/services
cp $ZABBIXDIR/zabbix-3.0.2/misc/init.d/fedora/core/zabbix_agentd /etc/init.d/
sed -i 's/BASEDIR=\/usr\/local/BASEDIR=\/usr\/local\/zabbix/g' /etc/init.d/zabbix_agentd
chkconfig --add zabbix_agentd
chkconfig zabbix_agentd on
#cfg zabbix_agentd.conf
IP=` ip a |grep 10.100 |awk '{print $2}'|awk -F '/' '{print $1}'`
HOSTNAME=`hostname`
ServerIp=172.18.1.7
ZABBIX_CFG_DIR=/usr/local/zabbix/etc/zabbix_agentd.conf
cp $ZABBIX_CFG_DIR /usr/local/zabbix/etc/zabbix_agentd.conf.bak
sed -i "s/Server=127.0.0.1/Server=$ServerIp/g" $ZABBIX_CFG_DIR
sed -i "s/ServerActive=127.0.0.1/ServerActive=$ServerIp/g" $ZABBIX_CFG_DIR
sed -i "s/Hostname=Zabbix server/Hostname=$HOSTNAME/g" $ZABBIX_CFG_DIR
sed -i "s/LogFile=\/tmp\/zabbix_agentd.log/LogFile=\/var\/log\/zabbix\/zabbix_agentd.log/g" $ZABBIX_CFG_DIR
echo 'PidFile=/var/tmp/zabbix_agentd.pid'>>$ZABBIX_CFG_DIR
echo "ListenIP=$IP">>$ZABBIX_CFG_DIR
mkdir /var/log/zabbix
touch /var/log/zabbix/zabbix_agentd.log
#chown -R zabbix.zabbix /var/log/zabbix/zabbix_agentd.log
chown -R zabbix.zabbix /var/log/zabbix
/etc/init.d/zabbix_agentd start
iptables -A INPUT -p tcp -s 172.18.1.7 -m multiport --dports 10050,10051 -jACCEPT
service iptables save
