# Test nfs

## deploy in blue zone for mitaka
```shell
in bluem4:

[root@bluem4 ~]# rpcinfo -p 10.0.0.18
   program vers proto   port  service
    100000    4   tcp    111  portmapper
    100000    3   tcp    111  portmapper
    100000    2   tcp    111  portmapper
    100000    4   udp    111  portmapper
    100000    3   udp    111  portmapper
    100000    2   udp    111  portmapper
    100024    1   udp  41289  status
    100024    1   tcp  57072  status
    100005    1   udp  20048  mountd
    100005    1   tcp  20048  mountd
    100005    2   udp  20048  mountd
    100005    2   tcp  20048  mountd
    100005    3   udp  20048  mountd
    100005    3   tcp  20048  mountd
    100003    3   tcp   2049  nfs
    100003    4   tcp   2049  nfs
    100227    3   tcp   2049  nfs_acl
    100003    3   udp   2049  nfs
    100003    4   udp   2049  nfs
    100227    3   udp   2049  nfs_acl
    100021    1   udp  40241  nlockmgr
    100021    3   udp  40241  nlockmgr
    100021    4   udp  40241  nlockmgr
    100021    1   tcp  57136  nlockmgr
    100021    3   tcp  57136  nlockmgr
    100021    4   tcp  57136  nlockmgr

in ctl-n3:

[root@ctl-n3 ~]# showmount -e  10.0.0.18
rpc mount export: RPC: Unable to receive; errno = No route to host
[root@ctl-n3 ~]# showmount -e  10.0.0.18
Export list for 10.0.0.18:
/data/openstack/glance/images *

exportfs -arv
[root@bluem4 Mitaka]# exportfs -arv
exporting *:/data/openstack/glance/images
```

# firewall
```shell
systemctl status firewalld
systemctl start firewalld
firewall-cmd --list-all
firewall-cmd --permanent --add-service=nfs
firewall-cmd --permanent --add-service=mountd
firewall-cmd --permanent --add-service=rpc-bind
firewall-cmd --reload
iptables -S


[root@ent-n1-x86 ~]# cat /etc/exports
/gpfs/gpfs_community/community_openstack   *(rw,sync,no_root_squash)
exportfs -arv

mount -t nfs 172.16.10.71:/gpfs/gpfs_community/community_openstack /gpfs/gpfs_community
mount -vvv -t nfs 172.16.10.76:/gpfs/gpfs_community/community_openstack /mnt/nfs/
mount -t nfs 172.16.10.76:/gpfs/gpfs_community/community_openstack /gpfs/gpfs_community
umount /gpfs/gpfs_community


```
# ubuntu install nfs client
```
apt-get update
apt-get install nfs-common
mount -t nfs bluem4:/data/openstack/glance/images /var/lib/glance/images
```


# power kvm neucloud1
```
systemctl start nfs-server.service
systemctl start rpcbind.service

