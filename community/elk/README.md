# elk

ansible-playbook centos_ntpd.yml


ansible elk-server -m ping
ansible elk-server -m shell -a "yum install -y nfs-utils"

/etc/rc.local
mkdir /data
mount x3550m5n01:/data/elk /data


# keepalive
ansible-playbook m_keepalive.yml

ansible-playbook m_elk.yml
/usr/share/elasticsearch/bin/elasticsearch-plugin list
/usr/share/elasticsearch/bin/elasticsearch-plugin install x-pack
/usr/share/elasticsearch/bin/elasticsearch-plugin install ingest-user-agent
/usr/share/elasticsearch/bin/elasticsearch-plugin install ingest-geoip


ansible-playbook m_kibana.yml
/usr/share/kibana/bin/kibana-plugin list
/usr/share/kibana/bin/kibana-plugin install x-pack



ansible-playbook m_logstash.yml

systemctl status elasticsearch
systemctl start elasticsearch
systemctl restart elasticsearch

systemctl status kibana
systemctl start kibana
systemctl restart kibana


firewall-cmd --add-port=9080-9081/tcp
firewall-cmd --permanent --add-port=9080-9081/tcp
