
Update /root/.bashrc for history
export HISTTIMEFORMAT="%F %T :: "
export HISTFILESIZE=1000000000
export HISTSIZE=1000000
export HISTIGNORE='ls'
export HISTCONTROL=ignoreboth
shopt -s histappend

Install libvirt qemu and bridge

yum install -y  libvirt qemu bridge-utils  libguestfs-tools 



Add bridge

brctl addbr br-admin
brctl addbr br-data
brctl addbr br-public


svx1 :
chmod a+x /etc/rc.d/rc.local
brctl addif br-admin enp26s0f0
ifconfig enp26s0f0 0 up
ifconfig br-admin 9.4.241.10/24 up
route add default gw  9.4.241.254 br-admin


Svx2
brctl addbr br-admin
brctl addbr br-data
brctl addbr br-public

brctl addif br-admin ens4f1
ifconfig ens4f1 0 up
ifconfig br-admin 9.4.241.4/24 up
route add default gw 9.4.241.254 br-admin



brctl addif br-data ens4f0
ifconfig ens4f0 0 up
ifconfig br-data 10.13.0.4/17 up



Config disk

yum install -y system-storage-manager
Ssm list

5\
systemctl enable  libvirtd.service
systemctl start  libvirtd.service
systemctl status  libvirtd.service

virsh list –all

For ansible remote control install some tools
yum install  libselinux-python python-devel


cp image to every server
mkdir /home/openstack_kvm
cd /home/openstack_kvm

scp -r CentOS7.2-x86_64_poc-HA-ctl0.xml CentOS7.2-x86_64_poc-HA-net0.xml compress_CentOS-7-x86_64-200G-pocHA0.qcow2 compress_CentOS-7-x86_64-200G-pocHAnet0.qcow2 svx1:/home/openstack_kvm/

scp -r CentOS7.2-x86_64_poc-HA-ctl1.xml CentOS7.2-x86_64_poc-HA-ctl2.xml CentOS7.2-x86_64_poc-HA-net1.xml CentOS7.2-x86_64_poc-HA-net2.xml compress_CentOS-7-x86_64-200G-pocHA1.qcow2 compress_CentOS-7-x86_64-200G-pocHA2.qcow2 compress_CentOS-7-x86_64-200G-pocHAnet1.qcow2 compress_CentOS-7-x86_64-200G-pocHAnet2.qcow2 svx2:/home/openstack_kvm/


mkdir /home/openstack_kvm/poc-HA-ctl0
mkdir /home/openstack_kvm/poc-HA-net0
mv compress_CentOS-7-x86_64-200G-pocHA0.qcow2 poc-HA-ctl0/CentOS-7-x86_64-200G-pocHA0.qcow2
mv compress_CentOS-7-x86_64-200G-pocHAnet0.qcow2 poc-HA-net0/CentOS-7-x86_64-200G-pocHAnet0.qcow2
virsh  list --all
virsh  define CentOS7.2-x86_64_poc-HA-ctl0.xml
virsh  define CentOS7.2-x86_64_poc-HA-net0.xml


mkdir /home/openstack_kvm/poc-HA-ctl1
mkdir /home/openstack_kvm/poc-HA-net1
mkdir /home/openstack_kvm/poc-HA-ctl2
mkdir /home/openstack_kvm/poc-HA-net2


cd /home/openstack_kvm
mv compress_CentOS-7-x86_64-200G-pocHA1.qcow2     poc-HA-ctl1/CentOS-7-x86_64-200G-pocHA1.qcow2
mv compress_CentOS-7-x86_64-200G-pocHAnet1.qcow2  poc-HA-net1/CentOS-7-x86_64-200G-pocHAnet1.qcow2
mv compress_CentOS-7-x86_64-200G-pocHA2.qcow2     poc-HA-ctl2/CentOS-7-x86_64-200G-pocHA2.qcow2
mv compress_CentOS-7-x86_64-200G-pocHAnet2.qcow2  poc-HA-net2/CentOS-7-x86_64-200G-pocHAnet2.qcow2

virsh  list --all
virsh  define CentOS7.2-x86_64_poc-HA-ctl1.xml
virsh  define CentOS7.2-x86_64_poc-HA-net1.xml
virsh  define CentOS7.2-x86_64_poc-HA-ctl2.xml
virsh  define CentOS7.2-x86_64_poc-HA-net2.xml


Reconfig Pacemaker cluster
Run 2updatesiteinfo.sh on three controller kvm  , to update site config, Then reboot the  kvm

galera_new_cluster  # to prepare start  mysql cluster 
pcs cluster status

pcs cluster auth
Username: hacluster
Password:devops1cloud
9.4.241.201: Authorized
9.4.241.203: Authorized
9.4.241.202: Authorized

pcs cluster start  --all

Update Data base;

pcs resource show HAPROXY_VIP
pcs resource update HAPROXY_VIP ip=9.4.241.200 cidr_netmask=24
pcs resource enable HAPROXY_VIP

2networkkvmsiteinfo.sh


Start cluster 
pcs cluster status
pcs cluster start --all
pcs cluster status

#check ha service
pcs resource

# start all service , first prepare start mariadb
galera_new_cluster
pcs cluster  unstandby --all
pcs resource




Restart RabbitMQ Service
pcs resource disable RABBITMQ-clone
pcs resource
pcs resource enable RABBITMQ-clone


Restart Mariadb Service
If you need restart mysql.First run cluster command galera_new_cluster in one node.

galera_new_cluster
pcs resource enable MYSQL-clone

check mysql cluster
mysql -u root -e "SHOW STATUS LIKE 'wsrep%';"


ELK service
http://9.4.241.7:9200/_plugin/head/

http://9.4.241.7:9200/_plugin/head/





















