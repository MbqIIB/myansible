# kvm
```
*/5 * * * * ping -c 10 192.168.32.4 > /tmp/ping.log
```

# net-n1
```
*/5 * * * * /opt/checknet.sh > /tmp/check.log 2>&1
```
