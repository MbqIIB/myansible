# main page

/usr/share/nginx/html/main.html


# config iptables in cltXXX
iptables -S
vim /etc/sysconfig/iptables.save 
and
vim /etc/sysconfig/iptables

-A INPUT -p tcp -m multiport --dports 80,9080 -m comment --comment "001 horizon 80,9080  incoming" -j ACCEPT


iptables-restore < /etc/sysconfig/iptables.save


# map
```
ssh -C -f -N -g -L 0.0.0.0:9080:ctl-vip:9080 root@ctl-vip

```

# haproxy

```
systemctl list-unit-files | grep nginx
nginx.service                                 disabled
```


update haproxy.cfg
```
listen nginx_cluster
  bind ctl-vip:9080
  balance  source
  option  tcpka
  option  tcplog
  server ctl-n1 ctl-n1:9080 check inter 2000 rise 2 fall 5
  server ctl-n2 ctl-n2:9080 check inter 2000 rise 2 fall 5
  server ctl-n3 ctl-n3:9080 check inter 2000 rise 2 fall 5


scp -r /etc/haproxy/haproxy.cfg ctl-n2:/etc/haproxy/haproxy.cfg
scp -r /etc/haproxy/haproxy.cfg ctl-n3:/etc/haproxy/haproxy.cfg
```


```
pcs resource create NGINX systemd:nginx op monitor interval=20s timeout=30s
pcs resource clone NGINX 
systemctl reload haproxy
pcs resource enable NGINX-clone
pcs resource disable NGINX-clone
```

pcs resource create HTTPD systemd:httpd op monitor interval=20s timeout=30s
pcs resource clone HTTPD 

pcs resource unclone HTTPD-clone
pcs resource delete HTTPD
