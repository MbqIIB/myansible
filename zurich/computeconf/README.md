# novnc
```
# update haproxy.cfg

listen compute-novnc-6080
  bind ctl-vip:6080
  bind ctl-mgmt-public-vip:6080
  balance  source
  option  tcpka
  option  tcplog
  server ctl-n1 ctl-n1:6080 check inter 2000 rise 2 fall 5
  server ctl-n2 ctl-n2:6080 check inter 2000 rise 2 fall 5
  server ctl-n3 ctl-n3:6080 check inter 2000 rise 2 fall 5

pcs resource restart HAPROXY

ansible-playbook ctl_novnc.yml
pcs resource restart NOVA_CONSOLE-clone
pcs resource restart NOVA_CONSOLEAUTH-clone
pcs resource restart NOVA_NOVNCPROXY-clone

# compute
./mitaka_servicerestart.sh restart


```
# End
