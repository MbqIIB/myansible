# mu network

## clear old network
```
[(DevOps)root@ansible ~]# nova interface-list bac27c90-6ba3-45d6-ae63-d7344e9ca81a
+------------+--------------------------------------+--------------------------------------+--------------+-------------------+
| Port State | Port ID                              | Net ID                               | IP addresses | MAC Addr          |
+------------+--------------------------------------+--------------------------------------+--------------+-------------------+
| ACTIVE     | 3f9000ec-977f-4e7f-95d5-f4e92942fb76 | 01e9986c-938c-4a52-a3c3-95e90c0f5cfc | 172.31.250.1 | fa:16:3e:93:95:7a |
+------------+--------------------------------------+--------------------------------------+--------------+-------------------+
[(DevOps)root@ansible ~]# nova interface-detach bac27c90-6ba3-45d6-ae63-d7344e9ca81a
usage: nova interface-detach <server> <port_id>
error: too few arguments
Try 'nova help interface-detach' for more information.
[(DevOps)root@ansible ~]# nova interface-detach bac27c90-6ba3-45d6-ae63-d7344e9ca81a 3f9000ec-977f-4e7f-95d5-f4e92942fb76
[(DevOps)root@ansible ~]# nova interface-list bac27c90-6ba3-45d6-ae63-d7344e9ca81a
+------------+---------+--------+--------------+----------+
| Port State | Port ID | Net ID | IP addresses | MAC Addr |
+------------+---------+--------+--------------+----------+
+------------+---------+--------+--------------+----------+

[(DevOps)root@ansible ~]# neutron router-list
+--------------------------------------+-------------+-------------------------------------------------------------------------------------------------------------------------+-------------+------+
| id                                   | name        | external_gateway_info                                                                                                   | distributed | ha   |
+--------------------------------------+-------------+-------------------------------------------------------------------------------------------------------------------------+-------------+------+
| 7cfc6848-e004-402d-9677-ccfcf92ddf2e | pub-router2 |

[(DevOps)root@ansible ~]# neutron router-gateway-clear 7cfc6848-e004-402d-9677-ccfcf92ddf2e
Removed gateway from router 7cfc6848-e004-402d-9677-ccfcf92ddf2e

[(DevOps)root@ansible ~]# neutron subnet-delete pub-subnet2
Deleted subnet: pub-subnet2

[(DevOps)root@ansible ~]# neutron net-delete pub-net2
Deleted network: pub-net2


ctl:
/etc/neutron/plugin.ini:159:flat_networks = *
/etc/neutron/plugins/ml2/ml2_conf.ini:201:network_vlan_ranges =ext-net,ext-net2

net:

/etc/neutron/l3_agent.ini:72:gateway_external_network_id =
/etc/neutron/l3_agent.ini:110:external_network_bridge =
/etc/neutron/plugins/ml2/openvswitch_agent.ini:218:bridge_mappings =ext-net:br-ex,ext-net2:br-ex2



neutron net-create pub-net2   --router:external \
        --provider:network_type flat --provider:physical_network ext-net2 \
        --name   pub-net2 

	[root@ctl-n1 ~]# neutron net-create pub-net2   --router:external \
		>         --provider:network_type flat --provider:physical_network ext-net2 \
		>         --name   pub-net2
		Created a new network:
		+---------------------------+--------------------------------------+
		| Field                     | Value                                |
		+---------------------------+--------------------------------------+
		| admin_state_up            | True                                 |
		| availability_zone_hints   |                                      |
		| availability_zones        |                                      |
		| created_at                | 2017-05-22T16:29:33                  |
		| description               |                                      |
		| id                        | 613a1a7d-dcbc-45ad-b716-5ab6ac99dcb9 |
		| ipv4_address_scope        |                                      |
		| ipv6_address_scope        |                                      |
		| is_default                | False                                |
		| mtu                       | 1500                                 |
		| name                      | pub-net2                             |
		| provider:network_type     | flat                                 |
		| provider:physical_network | ext-net2                             |
		| provider:segmentation_id  |                                      |
		| router:external           | True                                 |
		| shared                    | False                                |
		| status                    | ACTIVE                               |
		| subnets                   |                                      |
		| tags                      |                                      |
		| tenant_id                 | 7de3dec9204e4f52b704f391cd4413c4     |
		| updated_at                | 2017-05-22T16:29:33                  |
		+---------------------------+--------------------------------------+
		


neutron subnet-create pub-net2  \
		--name   pub-subnet2 \
		--allocation-pool start=172.31.250.2,end=172.31.250.239  \
		--gateway=172.31.255.254 --enable_dhcp=False  \
		--dns-nameserver 8.8.8.8 \
		172.31.192.0/18

		[root@ctl-n1 ~]# neutron subnet-create pub-net2  \
			>                 --name   pub-subnet2 \
			>                 --allocation-pool start=172.31.250.2,end=172.31.250.239  \
			>                 --gateway=172.31.255.254 --enable_dhcp=False  \
			>                 --dns-nameserver 8.8.8.8 \
			>                 172.31.192.0/18
			Created a new subnet:
			+-------------------+----------------------------------------------------+
			| Field             | Value                                              |
			+-------------------+----------------------------------------------------+
			| allocation_pools  | {"start": "172.31.250.2", "end": "172.31.250.239"} |
			| cidr              | 172.31.192.0/18                                    |
			| created_at        | 2017-05-22T16:29:51                                |
			| description       |                                                    |
			| dns_nameservers   | 8.8.8.8                                            |
			| enable_dhcp       | False                                              |
			| gateway_ip        | 172.31.255.254                                     |
			| host_routes       |                                                    |
			| id                | 3a3fec09-dc6f-4fc4-892d-37e06d68403e               |
			| ip_version        | 4                                                  |
			| ipv6_address_mode |                                                    |
			| ipv6_ra_mode      |                                                    |
			| name              | pub-subnet2                                        |
			| network_id        | 613a1a7d-dcbc-45ad-b716-5ab6ac99dcb9               |
			| subnetpool_id     |                                                    |
			| tenant_id         | 7de3dec9204e4f52b704f391cd4413c4                   |
			| updated_at        | 2017-05-22T16:29:51                                |
			+-------------------+----------------------------------------------------+


			neutron router-create pub-router2

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
			| id                      | 7cfc6848-e004-402d-9677-ccfcf92ddf2e |
			| name                    | pub-router2                          |
			| routes                  |                                      |
			| status                  | ACTIVE                               |
			| tenant_id               | 7de3dec9204e4f52b704f391cd4413c4     |
			+-------------------------+--------------------------------------+


			neutron router-gateway-set 7cfc6848-e004-402d-9677-ccfcf92ddf2e  613a1a7d-dcbc-45ad-b716-5ab6ac99dcb9
			[root@ctl-n1 ~]# neutron router-gateway-set 7cfc6848-e004-402d-9677-ccfcf92ddf2e  613a1a7d-dcbc-45ad-b716-5ab6ac99dcb9
			Set gateway for router 7cfc6848-e004-402d-9677-ccfcf92ddf2e



```

vim 
http://blog.webinno.cn/article/view/44
ref [http://blog.csdn.net/allenson1/article/details/53216960]


[root@ctl-n1 ~]# neutron subnet-create priv-net-vxlan1  10.13.0.0/16
Created a new subnet:
+-------------------+------------------------------------------------+
| Field             | Value                                          |
+-------------------+------------------------------------------------+
| allocation_pools  | {"start": "10.13.0.2", "end": "10.13.255.254"} |
| cidr              | 10.13.0.0/16                                   |
| created_at        | 2017-05-22T16:58:56                            |
| description       |                                                |
| dns_nameservers   |                                                |
| enable_dhcp       | True                                           |
| gateway_ip        | 10.13.0.1                                      |
| host_routes       |                                                |
| id                | 2ccbd971-b95c-40bb-97b3-f53fd2885638           |
| ip_version        | 4                                              |
| ipv6_address_mode |                                                |
| ipv6_ra_mode      |                                                |
| name              |                                                |
| network_id        | 06bdbd3e-e21e-42bd-a003-944e889bdfb3           |
| subnetpool_id     |                                                |
| tenant_id         | 7de3dec9204e4f52b704f391cd4413c4               |
| updated_at        | 2017-05-22T16:58:56                            |
+-------------------+------------------------------------------------+
neutron router-interface-add   7cfc6848-e004-402d-9677-ccfcf92ddf2e  2ccbd971-b95c-40bb-97b3-f53fd2885638
Added interface 9700b202-6be1-4314-8444-62ab21828acc to router 7cfc6848-e004-402d-9677-ccfcf92ddf2e.


[root@ctl-n1 ~]# neutron port-create priv-net-vxlan1 --fixed-ip subnet_id=2ccbd971-b95c-40bb-97b3-f53fd2885638
Created a new port:
+-----------------------+----------------------------------------------------------------------------------+
| Field                 | Value                                                                            |
+-----------------------+----------------------------------------------------------------------------------+
| admin_state_up        | True                                                                             |
| allowed_address_pairs |                                                                                  |
| binding:host_id       |                                                                                  |
| binding:profile       | {}                                                                               |
| binding:vif_details   | {}                                                                               |
| binding:vif_type      | unbound                                                                          |
| binding:vnic_type     | normal                                                                           |
| created_at            | 2017-05-22T17:01:43                                                              |
| description           |                                                                                  |
| device_id             |                                                                                  |
| device_owner          |                                                                                  |
| extra_dhcp_opts       |                                                                                  |
| fixed_ips             | {"subnet_id": "2ccbd971-b95c-40bb-97b3-f53fd2885638", "ip_address": "10.13.0.5"} |
| id                    | d25c5d43-9403-4eb9-a46d-9b6cdf18afe2                                             |
| mac_address           | fa:16:3e:72:a5:e0                                                                |
| name                  |                                                                                  |
| network_id            | 06bdbd3e-e21e-42bd-a003-944e889bdfb3                                             |
| security_groups       | f93a7244-b0ee-4717-a806-0d863ca5d8e2                                             |
| status                | DOWN                                                                             |
| tenant_id             | 7de3dec9204e4f52b704f391cd4413c4                                                 |
| updated_at            | 2017-05-22T17:01:43                                                              |
+-----------------------+----------------------------------------------------------------------------------+

[root@ctl-n1 ~]# nova list
+--------------------------------------+-------------------------------------------------+---------+------------+-------------+--------------------------------------------+
| ID                                   | Name                                            | Status  | Task State | Power State | Networks                                   |
+--------------------------------------+-------------------------------------------------+---------+------------+-------------+--------------------------------------------+
| eb0e1dff-298a-46ad-9673-fe90ab334243 | OSU-OSLVMPub1                                   | ACTIVE  | -          | Running     | priv-net-vxlan1=10.11.1.211                |
| bac27c90-6ba3-45d6-ae63-d7344e9ca81a | OSU-OSLVMPub2                                   | SHUTOFF | -          | Shutdown    |                                            |
| b010d75c-2dc8-4afa-9c23-6acd16f32279 | bnode6_5                                        | ACTIVE  | -          | Running     | baremetal-private=192.168.128.165          |
| ebc1e4e5-328a-472b-8860-9d2d881071eb | hnode6_11                                       | ACTIVE  | -          | Running     | baremetal-private=192.168.128.169          |
| e2badee9-4093-4ed8-97ac-4038fa8d1add | mytestvm1                                       | ACTIVE  | -          | Running     | qa_net=10.17.0.47, 172.31.216.54           |
| c4a43847-f958-4ae5-8704-39dfae8efcdb | net2test-fnode6-6-kvm4c8g100G-20170522_124115n0 | ACTIVE  | -          | Running     | priv-net-vxlan2=10.12.0.11                 |
| f32e7383-cee3-464b-b44c-016e7f9829e4 | test-fnode6-6-devopskvmsmall-20170505_050957n0  | ACTIVE  | -          | Running     | priv-net-vxlan1=10.11.1.193                |
| 23849889-ed2c-46aa-808d-f3db23062937 | test-fnode6-6-devopskvmsmall-20170514_214425n0  | ACTIVE  | -          | Running     | priv-net-vxlan1=10.11.1.195, 172.31.216.53 |
+--------------------------------------+-------------------------------------------------+---------+------------+-------------+--------------------------------------------+

nova interface-attach f32e7383-cee3-464b-b44c-016e7f9829e4 --port-id d25c5d43-9403-4eb9-a46d-9b6cdf18afe2


[root@ctl-n1 ~]# nova interface-list f32e7383-cee3-464b-b44c-016e7f9829e4
+------------+--------------------------------------+--------------------------------------+--------------+-------------------+
| Port State | Port ID                              | Net ID                               | IP addresses | MAC Addr          |
+------------+--------------------------------------+--------------------------------------+--------------+-------------------+
| ACTIVE     | 8847aa83-4726-4220-b495-2333c77c9e50 | 06bdbd3e-e21e-42bd-a003-944e889bdfb3 | 10.11.1.193  | fa:16:3e:8f:1c:a9 |
| ACTIVE     | d25c5d43-9403-4eb9-a46d-9b6cdf18afe2 | 06bdbd3e-e21e-42bd-a003-944e889bdfb3 | 10.13.0.5    | fa:16:3e:72:a5:e0 |

[root@ctl-n1 ~]# neutron floatingip-create pub-net1
Created a new floatingip:
+---------------------+--------------------------------------+
| Field               | Value                                |
+---------------------+--------------------------------------+
| description         |                                      |
| fixed_ip_address    |                                      |
| floating_ip_address | 172.31.216.152                       |
| floating_network_id | 21f68f9c-db79-4c58-ad5e-7072f615cc97 |
| id                  | c5a9384b-1c74-4891-9360-4f79deb1923b |
| port_id             |                                      |
| router_id           |                                      |
| status              | DOWN                                 |
| tenant_id           | 7de3dec9204e4f52b704f391cd4413c4     |
+---------------------+--------------------------------------+

[root@ctl-n1 ~]# neutron floatingip-create pub-net2
Created a new floatingip:
+---------------------+--------------------------------------+
| Field               | Value                                |
+---------------------+--------------------------------------+
| description         |                                      |
| fixed_ip_address    |                                      |
| floating_ip_address | 172.31.250.4                         |
| floating_network_id | 613a1a7d-dcbc-45ad-b716-5ab6ac99dcb9 |
| id                  | 85ff1ea4-a686-450a-8f12-64722e1798fd |
| port_id             |                                      |
| router_id           |                                      |
| status              | DOWN                                 |
| tenant_id           | 7de3dec9204e4f52b704f391cd4413c4     |
+---------------------+--------------------------------------+


[root@ctl-n1 ~]# neutron floatingip-associate c5a9384b-1c74-4891-9360-4f79deb1923b 8847aa83-4726-4220-b495-2333c77c9e50
Associated floating IP c5a9384b-1c74-4891-9360-4f79deb1923b
[root@ctl-n1 ~]# neutron floatingip-associate 85ff1ea4-a686-450a-8f12-64722e1798fd d25c5d43-9403-4eb9-a46d-9b6cdf18afe2
Associated floating IP 85ff1ea4-a686-450a-8f12-64722e1798fd




[(DevOps)root@ansible ~]# neutron subnet-list
+--------------------------------------+---------------------------------------------------+------------------+--------------------------------------------------------+
| id                                   | name                                              | cidr             | allocation_pools                                       |
+--------------------------------------+---------------------------------------------------+------------------+--------------------------------------------------------+
| 2ccbd971-b95c-40bb-97b3-f53fd2885638 |                                                   | 10.13.0.0/16     | {"start": "10.13.0.2", "end": "10.13.255.254"}         |
| a2c19f8e-eace-4396-b21b-98ffad3fa295 | priv-subnet-vxlan2                                | 10.12.0.0/16     | {"start": "10.12.0.2", "end": "10.12.255.254"}         |
| 8df08f76-e6db-480a-b882-de3538be479c | HA subnet tenant test                             | 169.254.192.0/18 | {"start": "169.254.192.1", "end": "169.254.255.254"}   |
| f4eb3420-c5f6-4c6f-a9c0-cfe340a4a56e | baremetal-private-subnet                          | 192.168.128.0/18 | {"start": "192.168.128.161", "end": "192.168.128.171"} |
| 38247e2a-0fed-4e19-98e7-61a6305c5073 | HA subnet tenant 7de3dec9204e4f52b704f391cd4413c4 | 169.254.192.0/18 | {"start": "169.254.192.1", "end": "169.254.255.254"}   |
| d0f38f67-1cac-4645-baf5-c518c073130f | HA subnet tenant dc9ac7739b4e4f78847ebad7f4b01614 | 169.254.192.0/18 | {"start": "169.254.192.1", "end": "169.254.255.254"}   |
| 0ae1763c-5607-4ab8-8334-7c0ae6ce8c91 | HA subnet tenant qa                               | 169.254.192.0/18 | {"start": "169.254.192.1", "end": "169.254.255.254"}   |
| d3a51b71-cf66-4076-a142-ab810132bd8c | priv-subnet-vxlan1                                | 10.11.0.0/16     | {"start": "10.11.0.2", "end": "10.11.255.254"}         |
| 2f99bebf-c721-463b-b971-35a510aaa01b | qa_subnet                                         | 10.17.0.0/24     | {"start": "10.17.0.2", "end": "10.17.0.254"}           |
| be54a337-2620-45a2-bc76-12abe3df2043 | subnet_prod                                       | 10.15.0.0/24     | {"start": "10.15.0.2", "end": "10.15.0.254"}           |
| 15b9c32d-621a-4bb8-8bfc-4ee33da419c5 | pub-subnet1                                       | 172.31.192.0/18  | {"start": "172.31.250.240", "end": "172.31.250.248"}   |
|                                      |                                                   |                  | {"start": "172.31.216.1", "end": "172.31.219.254"}     |
| 7dcdcfd6-c8de-4416-9568-fcc1e4d9663b | test_subnet                                       | 10.16.0.0/24     | {"start": "10.16.0.2", "end": "10.16.0.254"}           |
| 3a3fec09-dc6f-4fc4-892d-37e06d68403e | pub-subnet2                                       | 172.31.192.0/18  | {"start": "172.31.250.2", "end": "172.31.250.239"}     |
+--------------------------------------+---------------------------------------------------+------------------+--------------------------------------------------------+
[(DevOps)root@ansible ~]# neutron net-list
+--------------------------------------+----------------------------------------------------+-------------------------------------------------------+
| id                                   | name                                               | subnets                                               |
+--------------------------------------+----------------------------------------------------+-------------------------------------------------------+
| 5cada35f-a757-460c-9fe9-8f78abe0e62b | priv-net-vxlan2                                    | a2c19f8e-eace-4396-b21b-98ffad3fa295 10.12.0.0/16     |
| ada3018a-9957-4c60-9652-bb0beddf630e | HA network tenant qa                               | 0ae1763c-5607-4ab8-8334-7c0ae6ce8c91 169.254.192.0/18 |
| 06bdbd3e-e21e-42bd-a003-944e889bdfb3 | priv-net-vxlan1                                    | 2ccbd971-b95c-40bb-97b3-f53fd2885638 10.13.0.0/16     |
|                                      |                                                    | d3a51b71-cf66-4076-a142-ab810132bd8c 10.11.0.0/16     |
| 016e6f85-3f81-4b49-a85e-2366b6ee48a3 | HA network tenant dc9ac7739b4e4f78847ebad7f4b01614 | d0f38f67-1cac-4645-baf5-c518c073130f 169.254.192.0/18 |
| f4384783-8441-4d58-a90f-f8d361bd6eb2 | baremetal-private                                  | f4eb3420-c5f6-4c6f-a9c0-cfe340a4a56e 192.168.128.0/18 |
| 78c83a39-7b4f-4c06-88e9-5f420dc5778c | HA network tenant 7de3dec9204e4f52b704f391cd4413c4 | 38247e2a-0fed-4e19-98e7-61a6305c5073 169.254.192.0/18 |
| b2343fa4-2f8e-45ef-b207-c12f0307bba4 | HA network tenant test                             | 8df08f76-e6db-480a-b882-de3538be479c 169.254.192.0/18 |
| 054f69cd-adac-4f13-a678-14cb2059faaa | external_network                                   |                                                       |
| f06d4459-7f97-4fbc-bbc0-35d957a8a7aa | test_net                                           | 7dcdcfd6-c8de-4416-9568-fcc1e4d9663b 10.16.0.0/24     |
| 21f68f9c-db79-4c58-ad5e-7072f615cc97 | pub-net1                                           | 15b9c32d-621a-4bb8-8bfc-4ee33da419c5 172.31.192.0/18  |
| e2190bd3-62e1-4cf1-8e6b-088bb637d883 | qa_net                                             | 2f99bebf-c721-463b-b971-35a510aaa01b 10.17.0.0/24     |
| aa752cd6-86a0-4b88-868a-1cd4b9924553 | prod_net                                           | be54a337-2620-45a2-bc76-12abe3df2043 10.15.0.0/24     |
| 613a1a7d-dcbc-45ad-b716-5ab6ac99dcb9 | pub-net2                                           | 3a3fec09-dc6f-4fc4-892d-37e06d68403e 172.31.192.0/18  |
+--------------------------------------+----------------------------------------------------+-------------------------------------------------------+


 neutron subnet-show 15b9c32d-621a-4bb8-8bfc-4ee33da419c5
 +-------------------+------------------------------------------------------+
 | Field             | Value                                                |
 +-------------------+------------------------------------------------------+
 | allocation_pools  | {"start": "172.31.250.240", "end": "172.31.250.248"} |
 |                   | {"start": "172.31.216.1", "end": "172.31.219.254"}   |
 | cidr              | 172.31.192.0/18                                      |
 | created_at        | 2016-12-13T09:11:27                                  |
 | description       |                                                      |
 | dns_nameservers   | 8.8.8.8                                              |
 | enable_dhcp       | False                                                |
 | gateway_ip        | 172.31.255.254                                       |
 | host_routes       |                                                      |
 | id                | 15b9c32d-621a-4bb8-8bfc-4ee33da419c5                 |
 | ip_version        | 4                                                    |
 | ipv6_address_mode |                                                      |
 | ipv6_ra_mode      |                                                      |
 | name              | pub-subnet1                                          |
 | network_id        | 21f68f9c-db79-4c58-ad5e-7072f615cc97                 |
 | subnetpool_id     |                                                      |
 | tenant_id         | 7de3dec9204e4f52b704f391cd4413c4                     |
 | updated_at        | 2017-05-18T16:28:13                                  |
 +-------------------+------------------------------------------------------+

 neutron subnet-show pub-subnet2
 +-------------------+----------------------------------------------------+
 | Field             | Value                                              |
 +-------------------+----------------------------------------------------+
 | allocation_pools  | {"start": "172.31.250.2", "end": "172.31.250.239"} |
 | cidr              | 172.31.192.0/18                                    |
 | created_at        | 2017-05-22T16:29:51                                |
 | description       |                                                    |
 | dns_nameservers   | 8.8.8.8                                            |
 | enable_dhcp       | False                                              |
 | gateway_ip        | 172.31.255.254                                     |
 | host_routes       |                                                    |
 | id                | 3a3fec09-dc6f-4fc4-892d-37e06d68403e               |
 | ip_version        | 4                                                  |
 | ipv6_address_mode |                                                    |
 | ipv6_ra_mode      |                                                    |
 | name              | pub-subnet2                                        |
 | network_id        | 613a1a7d-dcbc-45ad-b716-5ab6ac99dcb9               |
 | subnetpool_id     |                                                    |
 | tenant_id         | 7de3dec9204e4f52b704f391cd4413c4                   |
 | updated_at        | 2017-05-22T16:29:51                                |
 +-------------------+----------------------------------------------------+


[(DevOps)root@ansible ~]# neutron  subnet-update pub-subnet2 --dns-nameserver 172.31.192.2
Updated subnet: pub-subnet2

neutron  subnet-update pub-subnet1 --dns-nameserver 172.31.192.2



[root@net-n2 ~]# neutron subnet-update 2ccbd971-b95c-40bb-97b3-f53fd2885638 --dns-nameserver 172.31.192.2 --dns-nameserver 10.13.0.2 --dns-nameserver 10.13.0.3
Updated subnet: 2ccbd971-b95c-40bb-97b3-f53fd2885638
[root@net-n2 ~]# neutron subnet-show 2ccbd971-b95c-40bb-97b3-f53fd2885638
+-------------------+------------------------------------------------+
| Field             | Value                                          |
+-------------------+------------------------------------------------+
| allocation_pools  | {"start": "10.13.0.2", "end": "10.13.255.254"} |
| cidr              | 10.13.0.0/16                                   |
| created_at        | 2017-05-22T16:58:56                            |
| description       |                                                |
| dns_nameservers   | 172.31.192.2                                   |
|                   | 10.13.0.2                                      |
|                   | 10.13.0.3                                      |
| enable_dhcp       | True                                           |
| gateway_ip        | 10.13.0.1                                      |
| host_routes       |                                                |
| id                | 2ccbd971-b95c-40bb-97b3-f53fd2885638           |
| ip_version        | 4                                              |
| ipv6_address_mode |                                                |
| ipv6_ra_mode      |                                                |
| name              | priv-subnet-vxlan3                             |
| network_id        | 06bdbd3e-e21e-42bd-a003-944e889bdfb3           |
| subnetpool_id     |                                                |
| tenant_id         | 7de3dec9204e4f52b704f391cd4413c4               |
| updated_at        | 2017-06-28T03:31:20                            |
+-------------------+------------------------------------------------+


[opuser@bash-xnode6-9-devopskvmsmall-20170613-045703n0 ~]$ cat /etc/resolv.conf 
; generated by /usr/sbin/dhclient-script
search openstacklocal
nameserver 172.31.192.2
nameserver 10.13.0.2
nameserver 10.13.0.3



# add net vlan2 to router1
neutron router-interface-add 6503ce62-86e1-4f10-a270-456826d7dc8f a2c19f8e-eace-4396-b21b-98ffad3fa295
Added interface 10e8b06f-3b28-49da-8932-1f80fc31fcfa to router 6503ce62-86e1-4f10-a270-456826d7dc8f.

ip netns exec qrouter-6503ce62-86e1-4f10-a270-456826d7dc8f bash

route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
10.11.0.0       0.0.0.0         255.255.0.0     U     0      0        0 qr-d306d273-49
10.12.0.0       0.0.0.0         255.255.0.0     U     0      0        0 qr-10e8b06f-3b
169.254.0.0     0.0.0.0         255.255.255.0   U     0      0        0 ha-7e79eeda-e1
169.254.192.0   0.0.0.0         255.255.192.0   U     0      0        0 ha-7e79eeda-e1
172.31.192.0    0.0.0.0         255.255.192.0   U     0      0        0 qg-6d6669a0-50

#route add default gw 172.31.255.254




| d3a51b71-cf66-4076-a142-ab810132bd8c | priv-subnet-vxlan1                                | 10.11.0.0/16     | {"start": "10.11.0.2", "end": "10.11.255.254"}         |

neutron subnet-update d3a51b71-cf66-4076-a142-ab810132bd8c --allocation-pool start=10.11.0.2,end=10.11.1.208
Updated subnet: d3a51b71-cf66-4076-a142-ab810132bd8c


neutron subnet-update d3a51b71-cf66-4076-a142-ab810132bd8c --allocation-pool start=10.11.0.2,end=10.11.0.4 --allocation-pool start=10.11.1.208,end=10.11.1.208
Updated subnet: d3a51b71-cf66-4076-a142-ab810132bd8c

