
## test logrotate
``` shell
logrotate -f /etc/logrotate.d/rsyslog 
```


>> ref:
https://www.digitalocean.com/community/tutorials/how-to-install-elasticsearch-1-7-logstash-1-5-and-kibana-4-1-elk-stack-on-centos-7


curl -XGET "http://localhost:9200/_template?pretty=true"  > template.json
vim template.json
del : logstash:{}
changed : logstash-* to openstack-*
curl -XPUT "http://localhost:9200/_template/openstack"   -d@template.json

delete all inss:
curl -XDELETE 'http://localhost:9200/*/'

sed -i "s/prd-elk-vip/yourvip/g" conf.d/99-output.conf

conf.d/01-input.conf
conf.d/03-openstack.conf
conf.d/99-output.conf

scp conf.d/*.conf prd-log:/etc/logstash/conf.d/


yum install httpd-tools

 htpasswd -b -c site_pass admin sv1xxxxx



# delete index
curl -XDELETE 192.168.11.4:9200/oslog-2014*
curl -XDELETE 192.168.11.4:9200/oslog-2015.01*
curl -XDELETE 192.168.11.4:9200/oslog-2015.02*
curl -XDELETE 192.168.11.4:9200/oslog-2015.02*
curl -XDELETE 192.168.11.4:9200/oslog-2015.03*
curl -XDELETE 192.168.11.4:9200/oslog-2015.02*
curl -XDELETE 192.168.11.4:9200/oslog-2015.04*

