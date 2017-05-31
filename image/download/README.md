# Download image

``` shell
wget http://cloud-images.ubuntu.com/releases/14.04/release/ubuntu-14.04-server-cloudimg-ppc64el-disk1.img


wget http://cloud-images.ubuntu.com/releases/16.04/release/ubuntu-16.04-server-cloudimg-amd64-disk1.img
wget http://cloud-images.ubuntu.com/releases/16.04/release/ubuntu-16.04-server-cloudimg-ppc64el-disk1.img

wget http://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2

https://docs.openstack.org/image-guide/

https://docs.openstack.org/image-guide/obtain-images.html#red-hat-enterprise-linux
https://access.redhat.com/downloads/content/69/ver=/rhel---6/6.6/x86_64/product-downloads
```

# ubuntu
``` shell
mv ubuntu-16.04-server-cloudimg-amd64-disk1.img ubuntu-16.04-server-x86_64-AnyDisk-v1.qcow2
IMAGENAME=ubuntu-16.04-server-x86_64-AnyDisk-v1.qcow2
ls -l $IMAGENAME
mkdir tmp
guestmount -w -a ${IMAGENAME} -i tmp/
vimdiff ubuntu16.04_cloud.cfg tmp/etc/cloud/cloud.cfg
cp ubuntu16.04_cloud.cfg tmp/etc/cloud/cloud.cfg
vim tmp/etc/cloud/cloud.cfg
guestunmount tmp/
./rc_kvm2glance.sh.mitaka  ubuntu-16.04-server-x86_64-AnyDisk-v1.cfg

glance image-show e13e20d6-2175-44c1-9d80-bd67f96829d2
glance  image-update --visibility public e13e20d6-2175-44c1-9d80-bd67f96829d2
```


# centos
``` shell
mkdir /home/downloadimage
cd /home/downloadimage

rpm -qa | grep   libguestfs-tools

yum install libguestfs-tools -y

mv CentOS-7-x86_64-GenericCloud.qcow2 CentOS-7-x86_64-AnyDisk-v1.qcow2
IMAGENAME=CentOS-7-x86_64-AnyDisk-v1.qcow2
mkdir tmp
guestmount -w -a ${IMAGENAME} -i tmp/

vimdiff centos_cloud.cfg tmp/etc/cloud/cloud.cfg
cp centos_cloud.cfg tmp/etc/cloud/cloud.cfg


vim tmp/etc/cloud/cloud.cfg
guestunmount tmp/

#glance  image-delete 30caab22-3b11-4366-9648-d2d3c6a376e5
./rc_kvm2glance.sh.mitaka CentOS-7-x86_64-AnyDisk-v1.cfg

./rc_kvm2glance.sh.mitaka CentOS-7-x86_64-AnyDisk-v1.cfg
glance  image-update --visibility public --name CentOS-7-x86_64-GenericCloud-anydisk-v1 347186ff-c576-42bd-b825-43ad73e208ba

glance image-show 41a69c3d-cae7-4dbe-9105-34c8fdbff073
glance  image-update --property sys_type=centos --property imageUuid=CentOS7 41a69c3d-cae7-4dbe-9105-34c8fdbff073 --visibility public
```

# End
