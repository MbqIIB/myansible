#### Shellinabox
###### centos
```shell
yum repolist
yum install epel-release
yum repolist
yum install -y shellinabox
systemctl enable shellinaboxd
systemctl start shellinaboxd
systemctl status shellinaboxd
iptables -S
netstat  -nap | grep 4200


nova stop 87dcea1f-e3b7-4e74-a7a2-f2c942e83082
nova show 87dcea1f-e3b7-4e74-a7a2-f2c942e83082
+--------------------------------------+--------------------------------------------------------------------------------+
| Property                             | Value                                                                          |
+--------------------------------------+--------------------------------------------------------------------------------+
| OS-DCF:diskConfig                    | MANUAL                                                                         |
| OS-EXT-AZ:availability_zone          | nova                                                                           |
| OS-EXT-SRV-ATTR:host                 | xnode6-9                                                                       |
| OS-EXT-SRV-ATTR:hypervisor_hostname  | xnode6-9                                                                       |
| OS-EXT-SRV-ATTR:instance_name        | instance-000005e2                                                              |
| OS-EXT-STS:power_state               | 4                                                                              |
| OS-EXT-STS:task_state                | -                                                                              |
| OS-EXT-STS:vm_state                  | stopped                                                                        |
| OS-SRV-USG:launched_at               | 2017-04-05T08:05:50.000000                                                     |
| OS-SRV-USG:terminated_at             | -                                                                              |
| accessIPv4                           |                                                                                |
| accessIPv6                           |                                                                                |
| config_drive                         |                                                                                |
| created                              | 2017-04-05T08:05:23Z                                                           |
| flavor                               | devops.kvm.small (24de09d4-c50a-48a2-850c-014c3d2d2fd1)                        |
| hostId                               | bb1d46d3453882cb61065f31b38229cd7b31bd8827c50d73f428aa8e                       |
| id                                   | 87dcea1f-e3b7-4e74-a7a2-f2c942e83082                                           |
| image                                | CentOS-7-x86_64-GenericCloud-anydisk-v1 (347186ff-c576-42bd-b825-43ad73e208ba) |
| key_name                             | CtlKey                                                                         |
| metadata                             | {}                                                                             |
| name                                 | bash-xnode6-9-devopskvmsmall-20170405_040519n0                                 |
| os-extended-volumes:volumes_attached | []                                                                             |
| priv-net-vxlan1 network              | 10.11.1.66, 172.31.216.163                                                     |
| security_groups                      | default                                                                        |
| status                               | SHUTOFF                                                                        |
| tenant_id                            | 4b574b27b5e44664aab81b1a9edd128a                                               |
| updated                              | 2017-04-05T08:19:55Z                                                           |
| user_id                              | d1d3b94705064227911b8483dfdbad35                                               |
+--------------------------------------+--------------------------------------------------------------------------------+

ssh xnode6-9

virt-sysprep -d instance-000005e2
[   0.0] Examining the guest ...
[   6.4] Performing "abrt-data" ...
[   6.4] Performing "bash-history" ...
[   6.4] Performing "blkid-tab" ...
[   6.4] Performing "crash-data" ...
[   6.4] Performing "cron-spool" ...
[   6.4] Performing "dhcp-client-state" ...
[   6.4] Performing "dhcp-server-state" ...
[   6.4] Performing "dovecot-data" ...
[   6.4] Performing "logfiles" ...
[   6.5] Performing "machine-id" ...
[   6.5] Performing "mail-spool" ...
[   6.5] Performing "net-hostname" ...
[   6.5] Performing "net-hwaddr" ...
[   6.5] Performing "pacct-log" ...
[   6.5] Performing "package-manager-cache" ...
[   6.5] Performing "pam-data" ...
[   6.5] Performing "puppet-data-log" ...
[   6.5] Performing "rh-subscription-manager" ...
[   6.5] Performing "rhn-systemid" ...
[   6.5] Performing "rpm-db" ...
[   6.5] Performing "samba-db-log" ...
[   6.5] Performing "script" ...
[   6.5] Performing "smolt-uuid" ...
[   6.5] Performing "ssh-hostkeys" ...
[   6.5] Performing "ssh-userdir" ...
[   6.6] Performing "sssd-db-log" ...
[   6.6] Performing "tmp-files" ...
[   6.6] Performing "udev-persistent-net" ...
[   6.6] Performing "utmp" ...
[   6.6] Performing "yum-uuid" ...
[   6.6] Performing "customize" ...
[   6.6] Setting a random seed
[   6.7] Performing "lvm-uuids" ...

IMAGENAME=CentOS-7-x86_64-GenericCloud-anydisk-v5
VMID=87dcea1f-e3b7-4e74-a7a2-f2c942e83082

IMAGENAME=CentOS-7.3-ppc64le-cloudimage-anydisk-v2
VMID=a1530150-e50b-4979-9263-c9f56cb8bf16

IMAGENAME=CentOS-7.3-ppc64le-cloudimage-anydisk-GPUcuda7.5-v2
VMID=fa1c8d17-ac31-4ab3-b51d-ac807c3f9b1d
nova image-create --show ${VMID} ${IMAGENAME}

IMAGEID=$(nova image-list | grep ${IMAGENAME} | awk -F '|' '{print $2}')
echo $IMAGEID
#IMAGEID=fbaf5327-c9bf-4814-a004-5f446dd3b4f4
glance image-update \
	--property image_type=image \
	--visibility public \
        ${IMAGEID}


	#--property accelerator_type=none \


#ExecStart=/usr/sbin/shellinaboxd -u $USER -g $GROUP --cert=${CERTDIR} --port=${PORT} $OPTS
#sed -i "s/^ExecStart.\+$/ExecStart=\/usr\/sbin\/shellinaboxd -u \$USER -g \$GROUP  --port=\${PORT} --disable-ssl \$OPTS/g" /usr/lib/systemd/system/shellinaboxd.service
sed -i "s/^ExecStart.\+$/ExecStart=\/usr\/sbin\/shellinaboxd -u \$USER -g \$GROUP  --cert=\${CERTDIR} --port=\${PORT} --disable-ssl \$OPTS/g" /usr/lib/systemd/system/shellinaboxd.service
#sed -i "s/^ExecStart.\+$/ExecStart=\/usr\/sbin\/shellinaboxd -u nobody -g nobody  --cert=\${CERTDIR} --port=\${PORT} --disable-ssl \$OPTS/g" /usr/lib/systemd/system/shellinaboxd.service
#sed -i "s/^ExecStart.\+$/ExecStart=\/usr\/sbin\/shellinaboxd  --port=\${PORT} --disable-ssl /g" /usr/lib/systemd/system/shellinaboxd.service

# vim /etc/sysconfig/shellinaboxd
systemctl daemon-reload
systemctl restart shellinaboxd
systemctl status shellinaboxd
ps -ef | grep shell


yum clean all
usermod -p '$1$super$440quZi/kSzmHnTJR1j3a.' root
usermod -p '$1$super$uXdjVfWjBYtxOPjOXZb3k0' opuser
usermod -aG sudo opuser
chage -d 0 root
chage -m 1 root
chage -M 90 root
chage -W 7 root
chage -d 0 opuser
chage -m 1 opuser
chage -M 90 opuser
chage -W 7 opuser
chage -l opuser
chage -l root
history -c
history -w

vim /etc/cloud/cloud.cfg
bootcmd:
  ## Turn off SELinux
  - setenforce 0
```
#### disable old image
``` shell
glance image-update --visibility private 347186ff-c576-42bd-b825-43ad73e208ba
glance image-update --visibility private 1b9d6b78-45b4-4c1e-a617-31c0450f5759 
```

#### ubuntu
``` shell
apt update
apt install -y shellinabox 
apt clean
#SHELLINABOX_ARGS="--no-beep --disable-ssl"
sed -i "s/^SHELLINABOX_ARGS.\+$/SHELLINABOX_ARGS=\"--no-beep --disable-ssl\"/g" /etc/default/shellinabox
service shellinabox restart
ps -ef |  grep shellinabox
```
##### make image
```
ssh xnode6-9

virt-sysprep -d instance-00000619
OLDIMAGENAME=ubuntu-16.04-server-cloudimg-amd64-anydisk-v1
IMAGENAME=ubuntu-16.04-server-cloudimg-amd64-anydisk-v2
VMID=adc4edd1-1d20-48e2-aa6c-92dddb91b9c3

virt-sysprep -d instance-00000622
IMAGENAME=ubuntu-16.04.2-server-cloudimg-ppc64el-anydisk1-v2
VMID=7e530db5-ab3f-42ee-895c-f7477beea300


virt-sysprep -d instance-00000625
IMAGENAME=ubuntu-16.04.2-server-cloudimg-ppc64el-anydisk1-GPUcuda7.5-v2
VMID=253f9a99-64ab-4e91-8976-3745d01772dc

virt-sysprep -d instance-00000628
IMAGENAME=ubuntu-16.04.2-server-cloudimg-ppc64el-anydisk1-GPUcuda7.5-v4
VMID=9c68cb37-b46c-42f7-b515-ac0b094055b3

virt-sysprep -d instance-000007c7
IMAGENAME=ubuntu-16.04.2-server-cloudimg-ppc64el-GPUcuda8-powerAI-v1
VMID=453ac0ad-8849-4d2e-9735-2f2e17336979

nova image-create --show ${VMID} ${IMAGENAME}

IMAGEID=$(nova image-list | grep ${IMAGENAME} | awk -F '|' '{print $2}')
echo $IMAGEID
nova image-list | grep  $IMAGEID
glance image-update \
        --property image_type=image \
        --visibility public \
        ${IMAGEID}

glance image-update \
        --property accelerator_type=gpu_pcie\
        --property image_type=image \
        --visibility public \
        ${IMAGEID}


#### disable old image
``` shell
OLDIMAGENAME=ubuntu-16.04.2-server-cloudimg-ppc64el-anydisk1-v1
OLDIMAGENAME=ubuntu-16.04-server-cloudimg-amd64-anydisk-v1
OLDIMAGENAME=ubuntu-16.04-server-cloudimg-ppc64le-anydisk-v1
OLDIMAGENAME=ubuntu-16.04.2-server-cloudimg-ppc64el-anydisk1-GPUcuda7.5-v1
OLDIMAGEID=$(glance image-list | grep $OLDIMAGENAME | awk -F '|' '{print $2}')
echo $OLDIMAGEID
glance image-update --visibility private $OLDIMAGEID
```




