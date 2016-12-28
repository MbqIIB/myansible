#!/bin/bash

########### Zabbix ########
sleep 5
curl -f http://169.254.169.254/latest/meta-data/hostname > /tmp/metadata-hostname 2>/tmp/metadata-hostname.log
HOSTNAME=$(cat /tmp/metadata-hostname |awk -F \. '{print $1}')
curl -f http://169.254.169.254/latest/meta-data/local-ipv4 > /tmp/metadata-local-ipv4 2>/tmp/metadata-local-ipv4.log
IPADD=$(cat /tmp/metadata-local-ipv4 |awk -F ' ' '{print $1}')

echo "$HOSTNAME"
echo "$IPADD"

sed -i "s/^Hostname.\+$/Hostname=${HOSTNAME}/g" /usr/local/zabbix/etc/zabbix_agentd.conf

#sed -i "s/^ListenIP.\+$/ListenIP=${IPADD}/g" /usr/local/zabbix/etc/zabbix_agentd.conf
sed -i "s/^ListenIP.\+$//g" /usr/local/zabbix/etc/zabbix_agentd.conf

/etc/init.d/zabbix_agentd restart

