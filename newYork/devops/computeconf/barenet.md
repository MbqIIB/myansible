
# add bridge net1/2/3
```
ifconfig eth4 0 up
ovs-vsctl add-br br-bare
ovs-vsctl add-port br-bare eth4
ifconfig br-bare 0 up

```


pcs resource
pcs resource disable NEUTRON_SERVER-clone
pcs resource enable NEUTRON_SERVER-clone



./service.sh restart
+ act=restart
+ systemctl restart neutron-dhcp-agent.service
+ systemctl restart neutron-l3-agent.service
+ systemctl restart neutron-lbaas-agent.service
+ systemctl restart neutron-metadata-agent.service
+ systemctl restart neutron-metering-agent.service
+ systemctl restart neutron-openvswitch-agent.service


neutron net-create bare-net1 --shared --provider:network_type flat --provider:physical_network ext-bare

neutron net-create bare-net1 --shared --provider:network_type flat --provider:physical_network ext-bare
Created a new network:
+---------------------------+--------------------------------------+
| Field                     | Value                                |
+---------------------------+--------------------------------------+
| admin_state_up            | True                                 |
| availability_zone_hints   |                                      |
| availability_zones        |                                      |
| created_at                | 2017-06-26T07:04:38                  |
| description               |                                      |
| id                        | 645744d0-5b1d-4573-b266-3d469cdf1c52 |
| ipv4_address_scope        |                                      |
| ipv6_address_scope        |                                      |
| mtu                       | 1500                                 |
| name                      | bare-net1                            |
| provider:network_type     | flat                                 |
| provider:physical_network | ext-bare                             |
| provider:segmentation_id  |                                      |
| router:external           | False                                |
| shared                    | True                                 |
| status                    | ACTIVE                               |
| subnets                   |                                      |
| tags                      |                                      |
| tenant_id                 | 7de3dec9204e4f52b704f391cd4413c4     |
| updated_at                | 2017-06-26T07:04:38                  |
+---------------------------+--------------------------------------+

net_id=645744d0-5b1d-4573-b266-3d469cdf1c52
neutron subnet-create --ip_version 4 --gateway 192.168.128.160 --name bare-subnet1 $net_id 192.168.128.0/18 --allocation-pool start=192.168.128.161,end=192.168.128.171 --enable-dhcp

[root@net-n2 ~]# net_id=645744d0-5b1d-4573-b266-3d469cdf1c52
[root@net-n2 ~]# neutron subnet-create --ip_version 4 --gateway 192.168.128.160 --name bare-subnet1 $net_id 192.168.128.0/18 --allocation-pool start=192.168.128.161,end=192.168.128.171 --enable-dhcp
Created a new subnet:
+-------------------+--------------------------------------------------------+
| Field             | Value                                                  |
+-------------------+--------------------------------------------------------+
| allocation_pools  | {"start": "192.168.128.161", "end": "192.168.128.171"} |
| cidr              | 192.168.128.0/18                                       |
| created_at        | 2017-06-26T07:06:45                                    |
| description       |                                                        |
| dns_nameservers   |                                                        |
| enable_dhcp       | True                                                   |
| gateway_ip        | 192.168.128.160                                        |
| host_routes       |                                                        |
| id                | f02cb0f2-a64b-45fc-8e29-dda0d1c48a55                   |
| ip_version        | 4                                                      |
| ipv6_address_mode |                                                        |
| ipv6_ra_mode      |                                                        |
| name              | bare-subnet1                                           |
| network_id        | 645744d0-5b1d-4573-b266-3d469cdf1c52                   |
| subnetpool_id     |                                                        |
| tenant_id         | 7de3dec9204e4f52b704f391cd4413c4                       |
| updated_at        | 2017-06-26T07:06:45                                    |
+-------------------+--------------------------------------------------------+

NODE_UUID=d22312ae-4805-44a6-bfa5-4114a3c8dca6
ironic node-set-provision-state $NODE_UUID manage
ironic node-set-provision-state $NODE_UUID inspect



 nova aggregate-create baremetal nova
 +----+-----------+-------------------+-------+--------------------------+
 | Id | Name      | Availability Zone | Hosts | Metadata                 |
 +----+-----------+-------------------+-------+--------------------------+
 | 10 | baremetal | nova              |       | 'availability_zone=nova' |
 +----+-----------+-------------------+-------+--------------------------+

 nova aggregate-set-metadata baremetal hypervisor_type=ironic
 Metadata has been successfully updated for aggregate 10.
 +----+-----------+-------------------+-------+----------------------------------------------------+
 | Id | Name      | Availability Zone | Hosts | Metadata                                           |
 +----+-----------+-------------------+-------+----------------------------------------------------+
 | 10 | baremetal | nova              |       | 'availability_zone=nova', 'hypervisor_type=ironic' |
 +----+-----------+-------------------+-------+----------------------------------------------------+


  nova aggregate-add-host baremetal hnode6-11
  Host hnode6-11 has been successfully added for aggregate 10 
  +----+-----------+-------------------+-------------+----------------------------------------------------+
  | Id | Name      | Availability Zone | Hosts       | Metadata                                           |
  +----+-----------+-------------------+-------------+----------------------------------------------------+
  | 10 | baremetal | nova              | 'hnode6-11' | 'availability_zone=nova', 'hypervisor_type=ironic' |
  +----+-----------+-------------------+-------------+----------------------------------------------------+


  scheduler_driver_task_period=60





  [root@ironic ~]# openstack flavor create --id auto --ram 4096 --disk 40 --vcpus 1 bare-small 
  +----------------------------+--------------------------------------+
  | Field                      | Value                                |
  +----------------------------+--------------------------------------+
  | OS-FLV-DISABLED:disabled   | False                                |
  | OS-FLV-EXT-DATA:ephemeral  | 0                                    |
  | disk                       | 40                                   |
  | id                         | 4341887d-ecd6-4606-9806-504b4923edd4 |
  | name                       | bare-small                           |
  | os-flavor-access:is_public | True                                 |
  | ram                        | 4096                                 |
  | rxtx_factor                | 1.0                                  |
  | swap                       |                                      |
  | vcpus                      | 1                                    |
  +----------------------------+--------------------------------------+
  [root@ironic ~]# openstack flavor set --property "cpu_arch"="ppc64le" --property "capabilities:boot_option"="local"  bare-small 



NODE_UUID=676d9c83-3006-4aa4-9560-7bd14ed0d1f1
ironic node-set-provision-state $NODE_UUID manage
ironic node-set-provision-state $NODE_UUID provide
ironic node-validate $NODE_UUID




[root@ironic ~]# neutron port-create --mac-address 7c:fe:90:96:83:11    645744d0-5b1d-4573-b266-3d469cdf1c52
Created a new port:
+-----------------------+----------------------------------------------------------------------------------------+
| Field                 | Value                                                                                  |
+-----------------------+----------------------------------------------------------------------------------------+
| admin_state_up        | True                                                                                   |
| allowed_address_pairs |                                                                                        |
| binding:host_id       |                                                                                        |
| binding:profile       | {}                                                                                     |
| binding:vif_details   | {}                                                                                     |
| binding:vif_type      | unbound                                                                                |
| binding:vnic_type     | normal                                                                                 |
| created_at            | 2017-06-27T00:37:57                                                                    |
| description           |                                                                                        |
| device_id             |                                                                                        |
| device_owner          |                                                                                        |
| extra_dhcp_opts       |                                                                                        |
| fixed_ips             | {"subnet_id": "f02cb0f2-a64b-45fc-8e29-dda0d1c48a55", "ip_address": "192.168.128.166"} |
| id                    | e445ce27-79d0-4851-90ba-017c57bd6b74                                                   |
| mac_address           | 7c:fe:90:96:83:11                                                                      |
| name                  |                                                                                        |
| network_id            | 645744d0-5b1d-4573-b266-3d469cdf1c52                                                   |
| security_groups       | f93a7244-b0ee-4717-a806-0d863ca5d8e2                                                   |
| status                | DOWN                                                                                   |
| tenant_id             | 7de3dec9204e4f52b704f391cd4413c4                                                       |
| updated_at            | 2017-06-27T00:37:57                                                                    |
+-----------------------+----------------------------------------------------------------------------------------+
[root@ironic ~]# nova boot --flavor ppc64le-baremetal --image 18e31a34-97da-457e-a660-5f5952727cdc --nic port-id=e445ce27-79d0-4851-90ba-017c57bd6b74 --security-groups default --key-name nova_key brnode13_5
+--------------------------------------+--------------------------------------------------------------------------------------+
| Property                             | Value                                                                                |
+--------------------------------------+--------------------------------------------------------------------------------------+
| OS-DCF:diskConfig                    | MANUAL                                                                               |
| OS-EXT-AZ:availability_zone          |                                                                                      |
| OS-EXT-SRV-ATTR:host                 | -                                                                                    |
| OS-EXT-SRV-ATTR:hypervisor_hostname  | -                                                                                    |
| OS-EXT-SRV-ATTR:instance_name        | instance-00000e35                                                                    |
| OS-EXT-STS:power_state               | 0                                                                                    |
| OS-EXT-STS:task_state                | scheduling                                                                           |
| OS-EXT-STS:vm_state                  | building                                                                             |
| OS-SRV-USG:launched_at               | -                                                                                    |
| OS-SRV-USG:terminated_at             | -                                                                                    |
| accessIPv4                           |                                                                                      |
| accessIPv6                           |                                                                                      |
| adminPass                            | e9tkdMEGihAS                                                                         |
| config_drive                         |                                                                                      |
| created                              | 2017-06-27T00:39:17Z                                                                 |
| flavor                               | ppc64le-baremetal (168ca213-2a73-46eb-986d-5d6b92e1db1b)                             |
| hostId                               |                                                                                      |
| id                                   | c3da9003-61c5-4a21-8fd4-7fd0c5e5514b                                                 |
| image                                | ubuntu-14.04.5-server-baremetal-ansiblekey_v1 (18e31a34-97da-457e-a660-5f5952727cdc) |
| key_name                             | nova_key                                                                             |
| metadata                             | {}                                                                                   |
| name                                 | brnode13_5                                                                           |
| os-extended-volumes:volumes_attached | []                                                                                   |
| progress                             | 0                                                                                    |
| security_groups                      | default                                                                              |
| status                               | BUILD                                                                                |
| tenant_id                            | 7de3dec9204e4f52b704f391cd4413c4                                                     |
| updated                              | 2017-06-27T00:39:17Z                                                                 |
| user_id                              | 2494b270b63f4a3ca88494b7c7ea07e2                                                     |
+--------------------------------------+--------------------------------------------------------------------------------------+
[root@ironic ~]# nova list
+--------------------------------------+------------+--------+------------+-------------+------------------------------------+
| ID                                   | Name       | Status | Task State | Power State | Networks                           |
+--------------------------------------+------------+--------+------------+-------------+------------------------------------+
| b010d75c-2dc8-4afa-9c23-6acd16f32279 | bnode6_5   | ACTIVE | -          | Running     | baremetal-private=192.168.128.165  |
| c3da9003-61c5-4a21-8fd4-7fd0c5e5514b | brnode13_5 | BUILD  | spawning   | NOSTATE     | bare-net1=192.168.128.166          |
| 3ccc101b-7c6e-43f7-b1eb-e0b342894806 | hnode6_11  | ERROR  | -          | NOSTATE     | baremetal-private=192.168.128.164  |
| 4629d0bf-31ba-4338-ba0d-cf383349b749 | mytestvm3  | ACTIVE | -          | Running     | qa_net=10.17.0.219, 172.31.216.101 |
+--------------------------------------+------------+--------+------------+-------------+------------------------------------+

ansible poc-server -m shell -a "ovs-vsctl show | grep 24fecf49"
nova boot --flavor ppc64le-baremetal --image f1502ec4-634a-44d0-939c-3d2f6bdb257a --nic port-id=e445ce27-79d0-4851-90ba-017c57bd6b74 --security-groups default --key-name nova_key brnode13_5




neutron router-create  bare-router
Created a new router:
+-------------------------+--------------------------------------+
| Field                   | Value                                |
+-------------------------+--------------------------------------+
| admin_state_up          | True                                 |
| availability_zone_hints |                                      |
| availability_zones      |                                      |
| description             |                                      |
| distributed             | False                                |
| external_gateway_info   |                                      |
| ha                      | True                                 |
| id                      | d023b873-2a27-4f1b-8246-28e8030357e3 |
| name                    | bare-router                          |
| routes                  |                                      |
| status                  | ACTIVE                               |
| tenant_id               | 7de3dec9204e4f52b704f391cd4413c4     |
+-------------------------+--------------------------------------+


eutron router-interface-delete 6503ce62-86e1-4f10-a270-456826d7dc8f f02cb0f2-a64b-45fc-8e29-dda0d1c48a55 
Removed interface from router 6503ce62-86e1-4f10-a270-456826d7dc8f.
[root@ironic ~]# neutron router-interface-add d023b873-2a27-4f1b-8246-28e8030357e3 f02cb0f2-a64b-45fc-8e29-dda0d1c48a55 
Added interface ff9ef0bd-4319-4710-baba-f878bb6ff4c4 to router d023b873-2a27-4f1b-8246-28e8030357e3.
[root@ironic ~]# neutron router-list
+--------------------------------------+----------------+-------------------------------------------------------------------------------------------------------------------------+-------------+------+
| id                                   | name           | external_gateway_info                                                                                                   | distributed | ha   |
+--------------------------------------+----------------+-------------------------------------------------------------------------------------------------------------------------+-------------+------+
| 6503ce62-86e1-4f10-a270-456826d7dc8f | pub-router1    | {"network_id": "f1537d14-2b6c-4ca8-82aa-bda8f02873b0", "enable_snat": true, "external_fixed_ips": [{"subnet_id":        | False       | True |
	|                                      |                | "d46da519-f3ce-42a9-a733-977fe84d3670", "ip_address": "172.31.216.2"}]}                                                 |             |      |
	| 7cfc6848-e004-402d-9677-ccfcf92ddf2e | pub-router2    | {"network_id": "613a1a7d-dcbc-45ad-b716-5ab6ac99dcb9", "enable_snat": true, "external_fixed_ips": [{"subnet_id":        | False       | True |
		|                                      |                | "3a3fec09-dc6f-4fc4-892d-37e06d68403e", "ip_address": "172.31.250.2"}]}                                                 |             |      |
		| a6d40d44-bdf7-4613-9729-590eba74d527 | qa_router      | {"network_id": "f1537d14-2b6c-4ca8-82aa-bda8f02873b0", "enable_snat": true, "external_fixed_ips": [{"subnet_id":        | False       | True |
			|                                      |                | "d46da519-f3ce-42a9-a733-977fe84d3670", "ip_address": "172.31.216.194"}]}                                               |             |      |
			| a9dc3c85-f77f-4154-99e3-5edffd196968 | pub-router-del | null                                                                                                                    | False       | True |
			| d023b873-2a27-4f1b-8246-28e8030357e3 | bare-router    | null                                                                                                                    | False       | True |
			| d6aefe6b-a386-4276-b721-0751f4cda919 | test_router    | {"network_id": "f1537d14-2b6c-4ca8-82aa-bda8f02873b0", "enable_snat": true, "external_fixed_ips": [{"subnet_id":        | False       | True |
				|                                      |                | "d46da519-f3ce-42a9-a733-977fe84d3670", "ip_address": "172.31.216.195"}]}                                               |             |      |
				| e64fefa8-20e7-4308-9b31-4070a536688d | prod_router    | {"network_id": "f1537d14-2b6c-4ca8-82aa-bda8f02873b0", "enable_snat": true, "external_fixed_ips": [{"subnet_id":        | False       | True |
					|                                      |                | "d46da519-f3ce-42a9-a733-977fe84d3670", "ip_address": "172.31.216.144"}]}                                               |             |      |
					+--------------------------------------+----------------+-------------------------------------------------------------------------------------------------------------------------+-------------+------+
					[root@ironic ~]# neutron router-gateway-set d023b873-2a27-4f1b-8246-28e8030357e3 645744d0-5b1d-4573-b266-3d469cdf1c52
					Bad router request: Network 645744d0-5b1d-4573-b266-3d469cdf1c52 is not an external network.
					Neutron server returns request_ids: ['req-f8114ca9-7ddf-4f19-a72a-ef3607c07d70']






neutron net-show 645744d0-5b1d-4573-b266-3d469cdf1c52					
neutron net-update 645744d0-5b1d-4573-b266-3d469cdf1c52 --router:external=true
neutron router-interface-add d023b873-2a27-4f1b-8246-28e8030357e3 f4eb3420-c5f6-4c6f-a9c0-cfe340a4a56e
neutron router-gateway-set d023b873-2a27-4f1b-8246-28e8030357e3 645744d0-5b1d-4573-b266-3d469cdf1c52




ovs-vsctl add-port br-int ovs-tap1 tag=12
ip addr
ip link add brbm-tap1 type veth peer name ovs-tap1
ovs-vsctl add-port br-bare brbm-tap1
ip link set dev brbm-tap1 up
ip link set dev ovs-tap1 up


neutron subnet-update f02cb0f2-a64b-45fc-8e29-dda0d1c48a55  --allocation-pool start=192.168.128.172,end=192.168.128.179
Updated subnet: f02cb0f2-a64b-45fc-8e29-dda0d1c48a55





































