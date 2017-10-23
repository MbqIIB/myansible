
# elk
```
node.name: ${HOSTNAME}
firewall-cmd --permanent --add-service=elasticsearch
```




#license
```
curl -XPUT -u elastic 'http://els-vip:9200/_xpack/license?acknowledge=true' -d @zhao-lin-8e4fd2e3-ee85-4712-9e01-0588b5b72bfe-v5.json
user 'elastic'
pass 'changeme'

curl -XPUT 'http://els-vip:9200/_xpack/license?acknowledge=true' -d @zhao-lin-8e4fd2e3-ee85-4712-9e01-0588b5b72bfe-v5.json

```

# plugin

```
cd /usr/share/elasticsearch
bin/elasticsearch-plugin list
bin/elasticsearch-plugin remove --purge x-pack
bin/elasticsearch-plugin install x-pack

cd /usr/share/kibana/
bin/kibana-plugin list
bin/kibana-plugin remove x-pack
bin/kibana-plugin install x-pack

```


# check status

```
curl -XGET 'http://els-n1:9200/_cluster/health?pretty'
curl -XGET 'http://els-n2:9200/_cluster/health?pretty'
curl -XGET 'http://els-n3:9200/_cluster/health?pretty'

```

# filebeat
```

ssh els-vip
cd /usr/share/elasticsearch
bin/elasticsearch-plugin list
bin/elasticsearch-plugin install ingest-user-agent
bin/elasticsearch-plugin install ingest-geoip
bin/elasticsearch-plugin remove --purge ingest-user-agent
bin/elasticsearch-plugin remove --purge ingest-geoip

```

# beat
```

yum install  packetbeat,metricbeat,filebeat,winlogbeat,heartbeat 
git clone https://github.com/elastic/beats
wget https://artifacts.elastic.co/downloads/beats/beats-dashboards/beats-dashboards-5.6.1.zip
unzip 

```

# template
```
curl -XGET "http://els-vip:9200/_template/openstack"  > op.template.json
curl -XDELETE 'http://els-vip:9200/_template/openstack'
curl -XPUT 'http://els-vip:9200/_template/openstack' -d@op.template.json


curl -XGET 'http://els-vip:9200/_cat/templates?v'
curl -XDELETE "http://localhost:9200/_template/filebeat"

curl -XPUT 'http://localhost:9200/_template/filebeat' -d@/etc/filebeat/filebeat.template.json

curl -XGET 'http://els-vip:9200/_cat/indices'
curl -XDELETE "http://localhost:9200/openstack-*"
curl -XPUT 'http://localhost:9200/indices/filebeat' -d@/root/beats-dashboards-5.6.1/filebeat/default/index-pattern/filebeat.json

curl -XGET 'http://els-vip:9200/_cat/indices?v'
curl -XPUT 'http://els-vip:9200/linzhbj?pretty'  
curl -XGET 'http://els-vip:9200/linzhbj?pretty'  
curl -XPOST http://els-vip:9200/linzhbj/external?pretty -d '{"name":"lin1","stock":'100'}'
curl -XPOST http://els-vip:9200/linzhbj/external?pretty -d '{"name":"lin2","stock":'101'}'
curl -XPOST http://els-vip:9200/linzhbj/external?pretty -d '{"name":"lin3","stock":'102'}'

curl -XGET 'http://localhost:9200/.kibana?pretty'
curl -XPUT 'http://localhost:9200/.kibana/index-pattern/filebeat-*' -d @dashboards/index-pattern/filebeat.json
curl -XPUT 'http://localhost:9200/.kibana/index-pattern/packetbeat-*' -d @dashboards/index-pattern/packetbeat.json
curl -XPUT 'http://localhost:9200/.kibana/index-pattern/topbeat-*' -d @dashboards/index-pattern/topbeat.json
curl -XPUT 'http://localhost:9200/.kibana/index-pattern/winlogbeat-*' -d @dashboards/index-pattern/winlogbeat.json

```

# ssl
```
yum install openssl
http://blog.csdn.net/liuchunming033/article/details/48467587
http://blog.csdn.net/liuchunming033/article/details/48470575

#openssl req -subj '/CN=blue212/' -x509 -days $((100*365)) -batch -nodes -newkey rsa:2048 -keyout ./pki/tls/provate/filebeat.key -out ./pki/tls/certs/filebeat.crt

openssl req -subj '/CN=blue212/' -x509 -days $((100*365)) -batch -nodes -newkey rsa:2048 -keyout ./server.key -out server.crt

https://www.ibm.com/support/knowledgecenter/zh/SSWHYP_4.0.0/com.ibm.apimgmt.cmc.doc/task_apionprem_gernerate_self_signed_openSSL.html

openssl req -newkey rsa:2048 -nodes -keyout key.pem -x509 -days 365 -out certificate.pem
openssl x509 -text -noout -in certificate.pem
openssl pkcs12 -inkey key.pem -in certificate.pem -export -out certificate.p12
openssl pkcs12 -in certificate.p12 -noout -info
```

#parse
```
https://172.31.250.21:4040/parse
$ openssl req -newkey rsa:2048 -new -nodes -keyout key.pem -out csr.pem
$ openssl x509 -req -days 365 -in csr.pem -signkey key.pem -out server.crt

openssl genrsa -out privatekey.pem 1024
openssl req -new -key privatekey.pem -out certrequest.csr
openssl x509 -req -in certrequest.csr -signkey privatekey.pem -out certificate.pem

```

