# add public vip

``` shell
pcs resource create HAPROXY_PUB_VIP ocf:heartbeat:IPaddr2 ip=172.31.252.70 cidr_netmask=18 op monitor interval=10s
pcs constraint colocation add HAPROXY_PUB_VIP HAPROXY INFINITY
pcs constraint order HAPROXY_PUB_VIP then HAPROXY


pcs resource update HAPROXY_PUB_VIP ip=172.31.250.1

pcs resource restart HAPROXY_PUB_VIP
neutron subnet-update a2c19f8e-eace-4396-b21b-98ffad3fa295 --dns-nameserver 172.31.192.2 --dns-nameserver 10.12.0.2
Updated subnet: a2c19f8e-eace-4396-b21b-98ffad3fa295

```

