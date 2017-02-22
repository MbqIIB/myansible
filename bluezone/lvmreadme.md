ssm list
pvcreate /dev/sdb1 /dev/sdc1 /dev/sdd1
pvscan
vgcreate data /dev/sdb1 /dev/sdc1 /dev/sdd1
vgdisplay
lvcreate  -l 100%FREE -n data data
lvdisplay
lvcreate  -l 100%FREE -n lv_data data
ssm list
mkfs.xfs /dev/data/lv_data
lvdisplay
ssm list
mount /dev/data/lv_data /mnt/

