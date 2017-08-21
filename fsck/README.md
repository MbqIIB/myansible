
# fsck
```
When system read only

cd /var/lib/nova/instances/17923101-9afc-47f2-bd6e-6357aa9b26f6/
ls
console.log  disk  disk.info  libvirt.xml


modprob/dev/nbd0 disk=8
modinfo bd
ls /dev/nbd*
qemu-nbd --connect=/dev/nbd0 disk
fdisk -l /dev/nbd0p1
fsck -y /dev/nbd0p1

```

# Ref
http://kumu-linux.github.io/blog/2014/06/23/fsck-qcow2

incloud lvm 
