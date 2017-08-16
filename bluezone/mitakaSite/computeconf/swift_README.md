
[root@svx-ctl1 ~]# rpm -qa | grep swift
openstack-swift-plugin-swift3-1.10-1.el7.noarch
openstack-swift-object-2.7.0-2.el7.noarch
openstack-swift-2.7.0-2.el7.noarch
openstack-swift-account-2.7.0-2.el7.noarch
openstack-swift-proxy-2.7.0-2.el7.noarch
openstack-swift-container-2.7.0-2.el7.noarch
python2-swiftclient-3.0.0-3.el7.noarch

systemctl list-unit-files | grep swift | grep enable

openstack-swift-account-auditor.service       enabled 
openstack-swift-account-reaper.service        enabled 
openstack-swift-account-replicator.service    enabled 
openstack-swift-account.service               enabled 
openstack-swift-container-auditor.service     enabled 
openstack-swift-container-replicator.service  enabled 
openstack-swift-container-updater.service     enabled 
openstack-swift-container.service             enabled 
openstack-swift-object-auditor.service        enabled 
openstack-swift-object-expirer.service        enabled 
openstack-swift-object-replicator.service     enabled 
openstack-swift-object-updater.service        enabled 
openstack-swift-object.service                enabled 
openstack-swift-proxy.service                 enabled 

[root@svx-ctl1 ~]# systemctl list-unit-files | grep swift | grep disabled

openstack-swift-account-auditor@.service      disabled
openstack-swift-account-reaper@.service       disabled
openstack-swift-account-replicator@.service   disabled
openstack-swift-account@.service              disabled
openstack-swift-container-auditor@.service    disabled
openstack-swift-container-reconciler.service  disabled
openstack-swift-container-replicator@.service disabled
openstack-swift-container-updater@.service    disabled
openstack-swift-container@.service            disabled
openstack-swift-object-auditor@.service       disabled
openstack-swift-object-replicator@.service    disabled
openstack-swift-object-updater@.service       disabled
openstack-swift-object@.service               disabled

systemctl start openstack-swift-account-auditor.service               
systemctl start openstack-swift-account-reaper.service                
systemctl start openstack-swift-account-replicator.service            
systemctl start openstack-swift-account.service                       
systemctl start openstack-swift-container-auditor.service             
systemctl start openstack-swift-container-replicator.service          
systemctl start openstack-swift-container-updater.service             
systemctl start openstack-swift-container.service                     
systemctl start openstack-swift-object-auditor.service                
systemctl start openstack-swift-object-expirer.service                
systemctl start openstack-swift-object-replicator.service             
systemctl start openstack-swift-object-updater.service                
systemctl start openstack-swift-object.service                        
systemctl start openstack-swift-proxy.service                         


systemctl start openstack-swift-container-auditor.service             
systemctl start openstack-swift-container-replicator.service          
systemctl start openstack-swift-container-updater.service             
systemctl start openstack-swift-container.service                     

systemctl stop openstack-swift-container-auditor.service             
systemctl stop openstack-swift-container-replicator.service          
systemctl stop openstack-swift-container-updater.service             
systemctl stop openstack-swift-container.service                     


systemctl stop openstack-swift-account-auditor.service               
systemctl stop openstack-swift-account-reaper.service                
systemctl stop openstack-swift-account-replicator.service            
systemctl stop openstack-swift-account.service                       

systemctl stop openstack-swift-container-auditor.service             
systemctl stop openstack-swift-container-replicator.service          
systemctl stop openstack-swift-container-updater.service             
systemctl stop openstack-swift-container.service                     

systemctl stop openstack-swift-object-auditor.service                
systemctl stop openstack-swift-object-expirer.service                
systemctl stop openstack-swift-object-replicator.service             
systemctl stop openstack-swift-object-updater.service                
systemctl stop openstack-swift-object.service                        

systemctl start openstack-swift-proxy.service                         



systemctl stop rsyncd
systemctl disable rsyncd

# config swift
rm -rf *.gz *.builder
swift-ring-builder account.builder create 10 3 1
swift-ring-builder account.builder add --ip 10.0.19.201 --region 1 --zone 1 --port 6002 --replication-ip 10.0.19.201 --replication-port 6002 --device swiftloopback --weight 10
swift-ring-builder account.builder add --ip 10.0.19.202 --region 1 --zone 2 --port 6002 --replication-ip 10.0.19.202 --replication-port 6002 --device swiftloopback --weight 10
swift-ring-builder account.builder add --ip 10.0.19.203 --region 1 --zone 3 --port 6002 --replication-ip 10.0.19.203 --replication-port 6002 --device swiftloopback --weight 10
swift-ring-builder account.builder
swift-ring-builder account.builder rebalance

swift-ring-builder container.builder create 10 3 1
swift-ring-builder container.builder add --ip 10.0.19.201 --region 1 --zone 1 --port 6001 --replication-ip 10.0.19.201 --replication-port 6001 --device swiftloopback --weight 10
swift-ring-builder container.builder add --ip 10.0.19.202 --region 1 --zone 2 --port 6001 --replication-ip 10.0.19.202 --replication-port 6001 --device swiftloopback --weight 10
swift-ring-builder container.builder add --ip 10.0.19.203 --region 1 --zone 3 --port 6001 --replication-ip 10.0.19.203 --replication-port 6001 --device swiftloopback --weight 10
swift-ring-builder container.builder
swift-ring-builder container.builder rebalance

swift-ring-builder object.builder create 10 3 1
swift-ring-builder object.builder add --ip 10.0.19.201 --region 1 --zone 1 --port 6000 --replication-ip 10.0.19.201 --replication-port 6000 --device swiftloopback --weight 10
swift-ring-builder object.builder add --ip 10.0.19.202 --region 1 --zone 2 --port 6000 --replication-ip 10.0.19.202 --replication-port 6000 --device swiftloopback --weight 10
swift-ring-builder object.builder add --ip 10.0.19.203 --region 1 --zone 3 --port 6000 --replication-ip 10.0.19.203 --replication-port 6000 --device swiftloopback --weight 10
swift-ring-builder object.builder 
swift-ring-builder object.builder rebalance


scp account.ring.gz container.ring.gz object.ring.gz ctl-n2:/etc/swift/
scp account.ring.gz container.ring.gz object.ring.gz ctl-n3:/etc/swift/



# ceph
http://www.cnblogs.com/sammyliu/p/4908668.html
# swift
http://www.cnblogs.com/sammyliu/p/4923432.html
http://www.cnblogs.com/sammyliu/p/4955241.html

# questions
1. how to config data storage network

# add new storage node
$ swift-ring-builder account.builder add z1-192.168.12.104:6002/d16 3000
$ swift-ring-builder container.builder add z1-192.168.12.104:6001/d16 3000
$ swift-ring-builder object.builder add z1-192.168.12.104:6000/d16 3000

$ swift-ring-builder account.builder rebalance
$ swift-ring-builder container.builder rebalance
$ swift-ring-builder object.builder rebalance

$ scp account.ring.gz swift-node-1:/etc/swift/account.ring.gz
$ scp container.ring.gz swift-node-1:/etc/swift/container.ring.gz
$ scp object.ring.gz swift-node-1:/etc/swift/account.ring.gz

$ scp account.ring.gz swift-node-2:/etc/swift/account.ring.gz
$ scp container.ring.gz swift-node-2:/etc/swift/container.ring.gz
$ scp object.ring.gz swift-node-2:/etc/swift/account.ring.gz
 ...
$ scp account.ring.gz swift-node-10:/etc/swift/account.ring.gz
$ scp container.ring.gz swift-node-10:/etc/swift/container.ring.gz
$ scp object.ring.gz swift-node-10:/etc/swift/account.ring.gz

