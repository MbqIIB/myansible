#!/bin/bash
#install zabbix agent
#add zabbix user
apt-get install gcc gcc-c++ cpp libstdc++
groupadd  zabbix
useradd  -g zabbix -s /sbin/nologin -M zabbix
#install zabbix_agent
ZABBIXDIR=/tmp/zabbix_agent_install/
tar zxvf $ZABBIXDIR/zabbix-3.0.2.tar.gz -C /tmp/zabbix_agent_install/
cd $ZABBIXDIR/zabbix-3.0.2 && ./configure --prefix=/usr/local/zabbix --enable-agent
echo "Begining make........................"
make && make install
chown -R zabbix:zabbix /usr/local/zabbix/
#add service port and cfg start script
cp misc/init.d/debian/zabbix-agent /etc/init.d/zabbix_agentd
sed -i 's/DAEMON=\/usr\/local\/sbin/DAEMON=\/usr\/local\/zabbix\/sbin/g' /etc/init.d/zabbix_agentd
chmod 755 /etc/init.d/zabbix_agentd
update-rc.d zabbix_agentd defaults
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
chmod 664 /var/log/zabbix_agentd.log
/etc/init.d/zabbix_agentd start
