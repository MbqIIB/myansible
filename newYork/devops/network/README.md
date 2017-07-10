# add public vip

``` shell
pcs resource create HAPROXY_PUB_VIP ocf:heartbeat:IPaddr2 ip=172.31.252.70 cidr_netmask=18 op monitor interval=10s
pcs constraint colocation add HAPROXY_PUB_VIP HAPROXY INFINITY
pcs constraint order HAPROXY_PUB_VIP then HAPROXY


pcs resource update HAPROXY_PUB_VIP ip=172.31.250.1

pcs resource restart HAPROXY_PUB_VIP
```
