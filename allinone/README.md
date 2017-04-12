systemctl disable   openstack-ceilometer-compute.service 
systemctl disable   openstack-cinder-api.service         
systemctl disable   openstack-cinder-backup.service      
systemctl disable   openstack-cinder-scheduler.service   
systemctl disable   openstack-cinder-volume.service      
systemctl disable   openstack-glance-api.service         
systemctl disable   openstack-glance-registry.service    
systemctl disable   openstack-losetup.service            
systemctl disable   openstack-nova-api.service           
systemctl disable   openstack-nova-cert.service          
systemctl disable   openstack-nova-compute.service       
systemctl disable   openstack-nova-conductor.service     
systemctl disable   openstack-nova-consoleauth.service   
systemctl disable   openstack-nova-novncproxy.service    
systemctl disable   openstack-nova-scheduler.service     
systemctl disable   neutron-ovs-cleanup.service          
systemctl disable   neutron-openvswitch-agent.service
systemctl disable   rabbitmq-server.service
systemctl disable httpd.service

  796  mysql -u root show
  797  mysql -u root -e "show databases;"
  798  mysql -u root -e "show tables from keystone;"
  799  mysql -u root -e "select *  from keystone.endpoint;"
  912  mysql -u root -e "select *  from keystone.endpoint;"
  913  mysql -u root -e "select *  from keystone.auth;"
  914  mysql -u root -e "show tables  from keystone;"
  915  mysql -u root -e "select *  from keystone.user;"
  916  mysql -u root -e "select *  from keystone.service;"
  917  mysql -u root -e "select *  from keystone.password;"
  918  mysql -u root -e "select *  from keystone.project;"
 1012  mysql -u root -e "select *  from keystone.project;"
mysql -u root -e "show databases;"
mysql -u root -e "drop databases keystone;"
mysql -u root -e "drop database keystone;"
mysql -u root -e "drop database glance;"
mysql -u root -e "drop database cinder;"
mysql -u root -e "drop database nova;"
mysql -u root -e "drop database nova_api;"
mysql -u root -e "drop database gnocchi;"
mysql -u root -e "drop database neutron;"
mysql -u root -e "show databases;"
 1023  history | grep mysql >> readme



systemctl disable firewalld
systemctl stop firewalld
systemctl disable NetworkManager
systemctl stop NetworkManager
systemctl enable network
systemctl start network



[root@svx-ctl1 ~]# yum list installed  | grep mitaka
gperftools-libs.x86_64                 2.4.91-1.el7                   @openstack-mitaka
mariadb-common.x86_64                  3:10.1.18-3.el7                @openstack-mitaka
mariadb-config.x86_64                  3:10.1.18-3.el7                @openstack-mitaka
mariadb-libs.x86_64                    3:10.1.18-3.el7                @openstack-mitaka
python-requests.noarch                 2.10.0-1.el7                   @openstack-mitaka
python-six.noarch                      1.10.0-3.el7                   @openstack-mitaka
python-urllib3.noarch                  1.15.1-2.el7                   @openstack-mitaka
python2-setuptools.noarch              22.0.5-1.el7                   @openstack-mitaka
[root@svx-ctl1 ~]#



packstack --allinone
yum install ntp
systemctl enable ntpd
systemctl start ntpd



packstack --answer-file=packstack-answers-20161220-180629.txt.donot.del

mysql -u root -pcb952c8800b942f4 -e "show databases;" -H 9.186.106.38





yum install -y system-storage-manager
yum install -y ntp telnet
yum install -y git tree vim
yum install -y centos-release-openstack-mitaka
systemctl enable ntpd
systemctl start ntpd

  296  2016-12-21 09:35:05 :: service mariadb start
  292  2016-12-21 09:34:33 :: service mariadb stop
  282  2016-12-21 09:32:49 :: mysqld_safe --init-file=./mysql-init.txt &
  285  2016-12-21 09:33:04 :: mysql -u root -pcb952c8800b942f4 -e "show databases;"
  286  2016-12-21 09:33:11 :: service mariadb start



systemctl list-units | grep nagios
systemctl stop nagios.service



CREATE\040DATABASE\040heat;
GRANT\040ALL\040PRIVILEGES\040ON\040heat.*\040TO\040'heat'@'localhost'\040IDENTIFIED\040BY\040'heatdomainpw';
GRANT\040ALL\040PRIVILEGES\040ON\040heat.*\040TO\040'heat'@'%'\040IDENTIFIED\040BY\040'heatdomainpw';
GRANT\040ALL\040PRIVILEGES\040ON\040heat.*\040TO\040'heat'@'localhost'\040IDENTIFIED\040BY\040'heatdbpw';
GRANT\040ALL\040PRIVILEGES\040ON\040heat.*\040TO\040'heat'@'%'\040IDENTIFIED\040BY\040'heatdbpw';



#openstack user create --password heat_admin heat
openstack user create  --password heatadmin heat --email heat@localhost

#openstack role add --project admin --user heat admin
openstack role add --project services --user heat admin

openstack service create --name heat  --description "Orchestration" orchestration
openstack service create --name heat-cfn --description "Orchestration"  cloudformation


yum install openstack-heat-api openstack-heat-api-cfn openstack-heat-engine


keystone endpoint-create --region RegionOne --service 41d30fa7de144f3c92082464d7448d14 --publicurl http://9.186.106.38:8004/v1/%\(tenant_id\)s --internalurl http://9.186.106.38:8004/v1/%\(tenant_id\)s --adminurl http://9.186.106.38:8004/v1/%\(tenant_id\)s

keystone endpoint-create --region RegionOne --service 0612532cbd754d51b3f1b68128f3acbf --publicurl http://9.186.106.38:8000/v1/%\(tenant_id\)s --internalurl http://9.186.106.38:8000/v1/%\(tenant_id\)s --adminurl http://9.186.106.38:8000/v1/%\(tenant_id\)s




openstack role create heat_stack_owner
openstack role add --project demo --user demo heat_stack_owner

openstack role create heat_stack_user

  234  2016-12-21 17:24:29 :: /bin/sh -c "heat-manage db_sync" heat
  235  2016-12-21 17:24:51 :: systemctl enable openstack-heat-api.service   openstack-heat-api-cfn.service openstack-heat-engine.service
  236  2016-12-21 17:24:56 :: systemctl start openstack-heat-api.service   openstack-heat-api-cfn.service openstack-heat-engine.service

systemctl restart openstack-heat-api.service   openstack-heat-api-cfn.service openstack-heat-engine.service

yum install docker-engine-1.10.3-1.el7.centos.x86_64 docker-engine-selinux-1.10.3-1.el7.centos
systemctl enable docker.service
systemctl start docker.service
useradd -g docker docker
echo "docker" | passwd --stdin docker
usermod -aG docker nova


yum install python-devel python-pip

pip install --upgrade pip
pip install -r requirements.txt


update subnets set cidr="172.24.4.224/24" where subnetpool_id="afca3972-d0ff-4c05-826a-5b1e211ed3f6";
neutron subnet-update  --allocation-pool start=172.24.4.2,end=172.24.4.238  afca3972-d0ff-4c05-826a-5b1e211ed3f6








