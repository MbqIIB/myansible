
# check root
```
ansible op-server -m shell -a "chage -l root"
```

# check compoute inferface

```

ansible compute-server -m shell -a "ifconfig br-tun"
ansible compute-server -m shell -a "cat /etc/rc.local"
ansible compute-server -m ping 

tcpdump  -nei br-int
tcpdump  -nei br-tun

ifconfig br-int 0 up
ifconfig br-tun 0 up
```


# config docker for nova
```
ansible compute-server -m shell -a "docker --version"
ansible compute-docker -m shell -a "tail /etc/nova/nova.conf"

[docker]
cpu_capping=true
set_fs_size=true
network_device_mtu=1440
client_timeout=3600


scp gpu_volume.py svx7:/usr/lib/python2.7/site-packages/nova/compute/

pip install --upgrade pip

```

# check public ip
```

ansible op-server -m shell -a "ip addr | grep 10.111.25"
```
