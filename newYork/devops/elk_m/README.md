
# ELK CONFIG
```
node.name: ${HOSTNAME}


firewall-cmd --permanent --add-service=elasticsearch


netstat  -nap |grep 9200
netstat  -nap |grep 9300
netstat  -nap |grep 5601
```


#license
```
curl -XPUT -u elastic 'http://els-vip:9200/_xpack/license?acknowledge=true' -d @zhao-lin-8e4fd2e3-ee85-4712-9e01-0588b5b72bfe-v5.json


user 'elastic'
pass 'changeme'
```
# install plugin


```
chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/ /etc/elasticsearch/ /data/

cd /usr/share/elasticsearch
bin/elasticsearch-plugin install x-pack


cd /usr/share/kibana/
bin/kibana-plugin install x-pack





[root@log-server ~]# chown logstash:logstash -R /etc/logstash/
[root@log-server ~]# chown logstash:logstash -R /etc/logstash/ /var/log/openstack/
[root@log-server ~]# chown logstash:logstash -R /etc/logstash/ /var/log/openstack/ /var/log/logstash/
[root@log-server ~]# service  logstash start
Redirecting to /bin/systemctl start  logstash.service
[root@log-server ~]# systemctl  enable logstash

```


# elk test
```
ansible-playbook -i elktest_host updatehosts.yml
ansible-playbook -i elktest_host updaterootpass.yml
ansible-playbook -i elktest_host m_elk.yml

```
