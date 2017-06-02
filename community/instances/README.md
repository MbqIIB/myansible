# create image by qemu

``` shell
/root/getcomputevm.sh 
df -h

virsh list --all
virsh edit instance-000038ac
virsh edit instance-00003b5b

qemu-img  info /data/nova/instances/bc0b1dc8-c8f4-4d93-92ba-e3114727eadc/disk
ll  /data/nova/instances/_base/12ed47346b0ae01fae066da8e997c32f1c434535
qemu-img  info /data/nova/instances/_base/12ed47346b0ae01fae066da8e997c32f1c434535
nova image-show 12ed47346b0ae01fae066da8e997c32f1c434535
qemu-img  info /data/nova/instances/_base/12ed47346b0ae01fae066da8e997c32f1c434535

/root/getcomputevm.sh

nova show bc0b1dc8-c8f4-4d93-92ba-e3114727eadc
nova image-show bbc43925-e6cb-4b59-a291-464995be6dc8

qemu-img  info /data/nova/instances/_base/12ed47346b0ae01fae066da8e997c32f1c434535

qemu-img convert -O raw /var/lib/nova/instances/6a78479e-296e-4ed9-99d7-4376a267c8de/disk new_img.raw

#edxapp911

qemu-img  info /data/nova/instances/bc0b1dc8-c8f4-4d93-92ba-e3114727eadc/disk
qemu-img convert -O raw /data/nova/instances/bc0b1dc8-c8f4-4d93-92ba-e3114727eadc/disk xyongcn-x86-kvm.4c16g20G-openedx-n4-20170602.raw
qemu-img convert -O qcow2 xyongcn-x86-kvm.4c16g20G-openedx-n4-20170602.raw xyongcn-x86-kvm.4c16g20G-openedx-n4-20170602.qcow2
qemu-img amend -f qcow2 -o compat=1.1 xyongcn-x86-kvm.4c16g20G-openedx-n4-20170602.qcow2



xyongcn-x86-kvm.2c8g20G-gitlab
qemu-img info /data/nova/instances/d07ee826-55ae-4ee6-9197-5692368c89c3/disk
qemu-img convert -O raw /data/nova/instances/d07ee826-55ae-4ee6-9197-5692368c89c3/disk xyongcn-x86-kvm.2c8g20G-gitlab-20170602.raw
qemu-img convert -O qcow2 xyongcn-x86-kvm.2c8g20G-gitlab-20170602.raw xyongcn-x86-kvm.2c8g20G-gitlab-20170602.qcow2

qemu-img amend -f qcow2 -o compat=1.1 xyongcn-x86-kvm.2c8g20G-gitlab-20170602.qcow2
```
ref:[compat qemu](http://blog.csdn.net/bluesy2008/article/details/49079125)
