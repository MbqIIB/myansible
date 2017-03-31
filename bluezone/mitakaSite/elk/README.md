
node.name: ${HOSTNAME}


firewall-cmd --permanent --add-service=elasticsearch




#license
curl -XPUT -u elastic 'http://els-vip:9200/_xpack/license?acknowledge=true' -d @zhao-lin-8e4fd2e3-ee85-4712-9e01-0588b5b72bfe-v5.json


user 'elastic'
pass 'changeme'
