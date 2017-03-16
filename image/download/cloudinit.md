



IMAGENAME=CentOS-7-x86_64-GenericCloud.qcow2
mkdir tmp
guestunmount tmp/

guestmount -w -a ${IMAGENAME} -i tmp/
vim tmp/etc/cloud/cloud.cfg
guestunmount tmp/
glance  image-delete 30caab22-3b11-4366-9648-d2d3c6a376e5
/home/rc_kvm2glance.sh.mitaka testcloudinit.cfg


glance  image-update --visibility public --name CentOS-7-x86_64-GenericCloud-anydisk-v1 347186ff-c576-42bd-b825-43ad73e208ba
