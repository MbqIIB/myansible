# cess
``` shell

[root@svx6 ~]# rpm -qa | grep zfs
kmod-zfs-0.6.5.8-1.el7.centos.x86_64
zfs-0.6.5.8-1.el7.centos.x86_64
zfs-release-1-3.el7.centos.noarch
zfs-dracut-0.6.5.8-1.el7.centos.x86_64
libzfs2-0.6.5.8-1.el7.centos.x86_64



cat /etc/sysconfig/docker-storage
DOCKER_STORAGE_OPTIONS="--storage-driver=zfs"

```
