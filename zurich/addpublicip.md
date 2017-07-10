
pcs resource create HAPROXY_PUB_VIP ocf:heartbeat:IPaddr2 ip=195.176.20.110 cidr_netmask=27 op monitor interval=10s
pcs constraint colocation add HAPROXY_PUB_VIP HAPROXY INFINITY
pcs constraint order HAPROXY_PUB_VIP then HAPROXY

pcs resource enable HAPROXY_PUB_VIP


pcs resource show HAPROXY_PUB_VIP
pcs resource update HAPROXY_PUB_VIP ip=195.176.20.110


listen compute-novnc-6080
  bind ctl-vip:6080
  bind 195.176.20.110:6080
  balance source
  server ctl-n1 ctl-n1:6080 check inter 15s fastinter 2s weight 1
  server ctl-n2 ctl-n2:6080 check inter 15s fastinter 2s weight 1
  server ctl-n3 ctl-n3:6080 check inter 15s fastinter 2s weight 1
  option httpchk GET / HTTP/1.1\r\nHost:\ localhost
  option tcpka



novncproxy_host=ctl-n1
novncproxy_port=6080
[vnc]

enabled=True
vncserver_listen=ctl-n1
vncserver_proxyclient_address=ctl-n1
novncproxy_base_url=http://ctl-n1:6080/vnc_auto.html

