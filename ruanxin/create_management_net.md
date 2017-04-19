# bluezone
``` shell
ovs-vsctl show
brctl addbr br-management

brctl addbr br-management
brctl addif br-management eth0
brctl addif br-management enP3p9s0f0

ifconfig  br-management 10.0.0.71/16 up
route add default gw 10.0.0.17 br-management
brctl addif br-management eth0


 1080* neutron net-create
 1081  neutron net-create  management   --shared
 1082  neutron subnet-list
 1085  neutron subnet-create --allocation-pool start=10.0.15.2,end=10.0.18.254 --gateway 10.0.0.17 --ip-version 4  --name subnet_management management 10.0.0.0/16 

ovs-vsctl add-port br-eth1 eth3 tag=1000

ovs-vsctl show
EXT_NET_NAME="management"
ip link add name ${EXT_NET_NAME}-INT type veth peer name ${EXT_NET_NAME}-EXT
ifconfig ${EXT_NET_NAME}-INT up
ifconfig ${EXT_NET_NAME}-EXT up

ifconfig 
brctl addif br-management ${EXT_NET_NAME}-EXT
ovs-vsctl add-port br-eth1 ${EXT_NET_NAME}-INT tag=1000
ovs-vsctl show


brctl addif br-management management-EXT
brctl show



neutron net-create  --shared --provider:segmentation_id=1200   --provider:network_type=default --provider:physical_network=default lin2

update ml2_network_segments set segmentation_id=1201 where network_id='52951b18-4245-41f5-b205-ccd9f42adcdf';
```


## create network
``` shell
neutron net-create  --shared management
+---------------------------+--------------------------------------+
| Field                     | Value                                |
+---------------------------+--------------------------------------+
| admin_state_up            | True                                 |
| availability_zone_hints   |                                      |
| availability_zones        | nova                                 |
| created_at                | 2017-04-19T02:33:43                  |
| description               |                                      |
| id                        | 7e3cbae1-5b90-4a54-807d-f453c8eb2494 |
| ipv4_address_scope        |                                      |
| ipv6_address_scope        |                                      |
| mtu                       | 1450                                 |
| name                      | management                           |
| provider:network_type     | vxlan                                |
| provider:physical_network |                                      |
| provider:segmentation_id  | 21                                   |
| router:external           | False                                |
| shared                    | True                                 |
| status                    | ACTIVE                               |
| subnets                   | 95582b5f-9c6b-4356-aeb8-1ca5a1a52583 |
| tags                      |                                      |
| tenant_id                 | 074b2880fec348e8aa766f64a4ac6e08     |
| updated_at                | 2017-04-19T02:33:43                  |
+---------------------------+--------------------------------------+

neutron subnet-create --allocation-pool start=192.168.33.1,end=192.168.33.255 --gateway 192.168.0.1 --ip-version 4  --name subnet_management management 192.168.0.0/18 
Created a new subnet:
+-------------------+----------------------------------------------------+
| Field             | Value                                              |
+-------------------+----------------------------------------------------+
| allocation_pools  | {"start": "192.168.33.1", "end": "192.168.33.255"} |
| cidr              | 192.168.0.0/18                                     |
| created_at        | 2017-04-19T02:40:14                                |
| description       |                                                    |
| dns_nameservers   |                                                    |
| enable_dhcp       | True                                               |
| gateway_ip        | 192.168.0.1                                        |
| host_routes       |                                                    |
| id                | 95582b5f-9c6b-4356-aeb8-1ca5a1a52583               |
| ip_version        | 4                                                  |
| ipv6_address_mode |                                                    |
| ipv6_ra_mode      |                                                    |
| name              | subnet_management                                  |
| network_id        | 7e3cbae1-5b90-4a54-807d-f453c8eb2494               |
| subnetpool_id     |                                                    |
| tenant_id         | 074b2880fec348e8aa766f64a4ac6e08                   |
| updated_at        | 2017-04-19T02:40:14                                |
+-------------------+----------------------------------------------------+

chmod a+x /etc/rc.d/rc.local
# add to /etc/rc.local
brctl addbr br-management
ifconfig eth0 0 up
brctl addif br-management eth0
ifconfig br-management  192.168.32.14/18 up
route add default gw 192.168.32.1 br-management


ovs-vsctl show
EXT_NET_NAME="management"
ip link add name ${EXT_NET_NAME}-INT type veth peer name ${EXT_NET_NAME}-EXT
ifconfig ${EXT_NET_NAME}-INT up
ifconfig ${EXT_NET_NAME}-EXT up

ifconfig 
brctl addif br-management ${EXT_NET_NAME}-EXT
#ovs-vsctl add-port br-int ${EXT_NET_NAME}-INT tag=21
# why 6 ,  tcpdump -nei br-int host 192.168.32.4
ovs-vsctl add-port br-int ${EXT_NET_NAME}-INT tag=6
ovs-vsctl show

ovs-vsctl show  | grep 6
        Port "tapaa3931e6-6f"
            tag: 6
            Interface "tapaa3931e6-6f"



brctl addif br-management management-EXT
brctl show
neutron  subnet-update  --dns-nameserver 114.114.114.114 --dns-nameserver 8.8.8.8 --dns-nameserver 30.30.0.1 550339d0-5b33-4abc-9ea9-f970219f2fc4

 neutron port-show aa3931e6-6fdf-4b20-815f-8289f0f22d9d
+-----------------------+-------------------------------------------------------------------------------------+
| Field                 | Value                                                                               |
+-----------------------+-------------------------------------------------------------------------------------+
| admin_state_up        | True                                                                                |
| allowed_address_pairs |                                                                                     |
| binding:host_id       | net-n1                                                                              |
| binding:profile       | {}                                                                                  |
| binding:vif_details   | {"port_filter": true, "ovs_hybrid_plug": true}                                      |
| binding:vif_type      | ovs                                                                                 |
| binding:vnic_type     | normal                                                                              |
| created_at            | 2017-04-19T02:40:15                                                                 |
| description           |                                                                                     |
| device_id             | dhcp90bfc535-7142-51cb-be45-ceacc2e11e8e-7e3cbae1-5b90-4a54-807d-f453c8eb2494       |
| device_owner          | network:dhcp                                                                        |
| dns_name              |                                                                                     |
| extra_dhcp_opts       |                                                                                     |
| fixed_ips             | {"subnet_id": "95582b5f-9c6b-4356-aeb8-1ca5a1a52583", "ip_address": "192.168.33.3"} |
| id                    | aa3931e6-6fdf-4b20-815f-8289f0f22d9d                                                |
| mac_address           | fa:16:3e:cb:12:d6                                                                   |
| name                  |                                                                                     |
| network_id            | 7e3cbae1-5b90-4a54-807d-f453c8eb2494                                                |
| security_groups       |                                                                                     |
| status                | ACTIVE                                                                              |
| tenant_id             | 074b2880fec348e8aa766f64a4ac6e08                                                    |
| updated_at            | 2017-04-19T02:40:16                                                                 |
+-----------------------+-------------------------------------------------------------------------------------+


```
