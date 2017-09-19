
node.name: ${HOSTNAME}


firewall-cmd --permanent --add-service=elasticsearch




#license
```
curl -XPUT -u elastic 'http://els-vip:9200/_xpack/license?acknowledge=true' -d @zhao-lin-8e4fd2e3-ee85-4712-9e01-0588b5b72bfe-v5.json
user 'elastic'
pass 'changeme'


```

# plugin
```
cd /usr/share/elasticsearch
bin/elasticsearch-plugin list
bin/elasticsearch-plugin remove --purge x-pack
bin/elasticsearch-plugin install x-pack

cd /usr/share/kibana/
bin/kibana-plugin remove x-pack
bin/kibana-plugin install x-pack

```


# check status

```
curl -XGET 'http://els-n1:9200/_cluster/health?pretty'
curl -XGET 'http://els-n2:9200/_cluster/health?pretty'
curl -XGET 'http://els-n3:9200/_cluster/health?pretty'
```

