
neutron net-create pub-net1   -- --router:external=True
Created a new network:
+---------------------------+--------------------------------------+
| Field                     | Value                                |
+---------------------------+--------------------------------------+
| admin_state_up            | True                                 |
| availability_zone_hints   |                                      |
| availability_zones        |                                      |
| created_at                | 2016-12-13T09:02:17                  |
| description               |                                      |
| id                        | 21f68f9c-db79-4c58-ad5e-7072f615cc97 |
| ipv4_address_scope        |                                      |
| ipv6_address_scope        |                                      |
| is_default                | False                                |
| mtu                       | 1450                                 |
| name                      | pub-net1                             |
| provider:network_type     | vxlan                                |
| provider:physical_network |                                      |
| provider:segmentation_id  | 47                                   |
| router:external           | True                                 |
| shared                    | False                                |
| status                    | ACTIVE                               |
| subnets                   |                                      |
| tags                      |                                      |
| tenant_id                 | 7de3dec9204e4f52b704f391cd4413c4     |
| updated_at                | 2016-12-13T09:02:17                  |
+---------------------------+--------------------------------------+

#172.31.252.68
#172.31.252.69
#172.31.252.70
#172.31.252.71
#172.31.252.72


neutron subnet-create pub-net1  \
        --name   pub-subnet1 \
        --allocation-pool start=172.31.252.68,end=172.31.252.72  \
        --gateway=172.31.255.254 --enable_dhcp=False  \
        --dns-nameserver 8.8.8.8 \
        172.31.255.254/16

Created a new subnet:
+-------------------+----------------------------------------------------+
| Field             | Value                                              |
+-------------------+----------------------------------------------------+
| allocation_pools  | {"start": "172.31.252.68", "end": "172.31.252.72"} |
| cidr              | 172.31.0.0/16                                      |
| created_at        | 2016-12-13T09:11:27                                |
| description       |                                                    |
| dns_nameservers   | 8.8.8.8                                            |
| enable_dhcp       | False                                              |
| gateway_ip        | 172.31.255.254                                     |
| host_routes       |                                                    |
| id                | 15b9c32d-621a-4bb8-8bfc-4ee33da419c5               |
| ip_version        | 4                                                  |
| ipv6_address_mode |                                                    |
| ipv6_ra_mode      |                                                    |
| name              |                                                    |
| network_id        | 21f68f9c-db79-4c58-ad5e-7072f615cc97               |
| subnetpool_id     |                                                    |
| tenant_id         | 7de3dec9204e4f52b704f391cd4413c4                   |
| updated_at        | 2016-12-13T09:11:27                                |
+-------------------+----------------------------------------------------+
[root@ctl-n1 ~]# 
[root@ctl-n1 ~]# neutron router-create pub-router
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
| id                      | a9dc3c85-f77f-4154-99e3-5edffd196968 |
| name                    | pub-router                           |
| routes                  |                                      |
| status                  | ACTIVE                               |
| tenant_id               | 7de3dec9204e4f52b704f391cd4413c4     |
+-------------------------+--------------------------------------+

neutron router-gateway-set a9dc3c85-f77f-4154-99e3-5edffd196968 21f68f9c-db79-4c58-ad5e-7072f615cc97
Set gateway for router a9dc3c85-f77f-4154-99e3-5edffd196968

neutron net-create priv-net-vxlan1
Created a new network:
+---------------------------+--------------------------------------+
| Field                     | Value                                |
+---------------------------+--------------------------------------+
| admin_state_up            | True                                 |
| availability_zone_hints   |                                      |
| availability_zones        |                                      |
| created_at                | 2016-12-13T09:16:23                  |
| description               |                                      |
| id                        | 06bdbd3e-e21e-42bd-a003-944e889bdfb3 |
| ipv4_address_scope        |                                      |
| ipv6_address_scope        |                                      |
| mtu                       | 1450                                 |
| name                      | priv-net-vxlan1                      |
| provider:network_type     | vxlan                                |
| provider:physical_network |                                      |
| provider:segmentation_id  | 36                                   |
| router:external           | False                                |
| shared                    | False                                |
| status                    | ACTIVE                               |
| subnets                   |                                      |
| tags                      |                                      |
| tenant_id                 | 7de3dec9204e4f52b704f391cd4413c4     |
| updated_at                | 2016-12-13T09:16:23                  |
+---------------------------+--------------------------------------+


neutron subnet-create --name priv-subnet-vxlan1 \
                --enable_dhcp=True \
                priv-net-vxlan1 10.11.0.0/16

Created a new subnet:
+-------------------+------------------------------------------------+
| Field             | Value                                          |
+-------------------+------------------------------------------------+
| allocation_pools  | {"start": "10.11.0.2", "end": "10.11.255.254"} |
| cidr              | 10.11.0.0/16                                   |
| created_at        | 2016-12-13T09:19:31                            |
| description       |                                                |
| dns_nameservers   |                                                |
| enable_dhcp       | True                                           |
| gateway_ip        | 10.11.0.1                                      |
| host_routes       |                                                |
| id                | d3a51b71-cf66-4076-a142-ab810132bd8c           |
| ip_version        | 4                                              |
| ipv6_address_mode |                                                |
| ipv6_ra_mode      |                                                |
| name              | priv-subnet-vxlan1                             |
| network_id        | 06bdbd3e-e21e-42bd-a003-944e889bdfb3           |
| subnetpool_id     |                                                |
| tenant_id         | 7de3dec9204e4f52b704f391cd4413c4               |
| updated_at        | 2016-12-13T09:19:31                            |
+-------------------+------------------------------------------------+


 neutron router-interface-add   a9dc3c85-f77f-4154-99e3-5edffd196968 d3a51b71-cf66-4076-a142-ab810132bd8c
Added interface 2a0e541c-10a1-4f05-8516-6b8847b8c5eb to router a9dc3c85-f77f-4154-99e3-5edffd196968.

neutron subnet-update --name   pub-subnet1 15b9c32d-621a-4bb8-8bfc-4ee33da419c5


neutron subnet-update  15b9c32d-621a-4bb8-8bfc-4ee33da419c5 --allocation-pool start=172.31.252.68,end=172.31.252.72 --allocation-pool start=172.31.216.1,end=172.31.219.254
Updated subnet: 15b9c32d-621a-4bb8-8bfc-4ee33da419c5





MariaDB [neutron]> update subnets set cidr='172.31.192.0/18' where name='pub-subnet1';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MariaDB [neutron]> select * from subnets;
+----------------------------------+--------------------------------------+---------------------------------------------------+--------------------------------------+------------+------------------+-----------------+-------------+--------------+-------------------+---------------+------------------+
| tenant_id                        | id                                   | name                                              | network_id                           | ip_version | cidr             | gateway_ip      | enable_dhcp | ipv6_ra_mode | ipv6_address_mode | subnetpool_id | standard_attr_id |
+----------------------------------+--------------------------------------+---------------------------------------------------+--------------------------------------+------------+------------------+-----------------+-------------+--------------+-------------------+---------------+------------------+
| 7de3dec9204e4f52b704f391cd4413c4 | 15b9c32d-621a-4bb8-8bfc-4ee33da419c5 | pub-subnet1                                       | 21f68f9c-db79-4c58-ad5e-7072f615cc97 |          4 | 172.31.192.0/18  | 172.31.255.254  |           0 | NULL         | NULL              | NULL          |               37 |
|                                  | 38247e2a-0fed-4e19-98e7-61a6305c5073 | HA subnet tenant 7de3dec9204e4f52b704f391cd4413c4 | 78c83a39-7b4f-4c06-88e9-5f420dc5778c |          4 | 169.254.192.0/18 | NULL            |           0 | NULL         | NULL              | NULL          |               61 |
| 7de3dec9204e4f52b704f391cd4413c4 | d3a51b71-cf66-4076-a142-ab810132bd8c | priv-subnet-vxlan1                                | 06bdbd3e-e21e-42bd-a003-944e889bdfb3 |          4 | 10.11.0.0/16     | 10.11.0.1       |           1 | NULL         | NULL              | NULL          |               79 |
| 7de3dec9204e4f52b704f391cd4413c4 | f4eb3420-c5f6-4c6f-a9c0-cfe340a4a56e | baremetal-private-subnet                          | f4384783-8441-4d58-a90f-f8d361bd6eb2 |          4 | 192.168.128.0/18 | 192.168.128.160 |           1 | NULL         | NULL              | NULL          |             1811 |
+----------------------------------+--------------------------------------+---------------------------------------------------+--------------------------------------+------------+------------------+-----------------+-------------+--------------+-------------------+---------------+------------------+
4 rows in set (0.00 sec)


neutron subnet-update  15b9c32d-621a-4bb8-8bfc-4ee33da419c5 --allocation-pool start=172.31.216.1,end=172.31.219.254

neutron net-create pub-net2   \
        -- --router:external=True  

neutron subnet-create pub-net2  \
        --name   pub-subnet2 \
        --allocation-pool start=172.31.250.2,end=172.31.250.254  \
        --gateway=172.31.255.254 --enable_dhcp=False  \
        --dns-nameserver 8.8.8.8 \
        172.31.192.0/18


[root@ansible devops]# neutron net-create pub-net2   -- --router:external=True

        --name   pub-subnet2 \
        --allocation-pool start=172.31.250.1,end=172.31.250.210  \
        --gateway=172.31.255.254 --enable_dhcp=False  \
        --dns-nameserver 8.8.8.8 \
        172.31.192.0/18

Created a new network:
+---------------------------+--------------------------------------+
| Field                     | Value                                |
+---------------------------+--------------------------------------+
| admin_state_up            | True                                 |
| availability_zone_hints   |                                      |
| availability_zones        |                                      |
| created_at                | 2017-04-17T09:02:54                  |
| description               |                                      |
| id                        | 1bcf1008-c001-42cc-8f99-6a663017b150 |
| ipv4_address_scope        |                                      |
| ipv6_address_scope        |                                      |
| is_default                | False                                |
| mtu                       | 1450                                 |
| name                      | pub-net2                             |
| provider:network_type     | vxlan                                |
| provider:physical_network |                                      |
| provider:segmentation_id  | 94                                   |
| router:external           | True                                 |
| shared                    | False                                |
| status                    | ACTIVE                               |
| subnets                   |                                      |
| tags                      |                                      |
| tenant_id                 | 7de3dec9204e4f52b704f391cd4413c4     |
| updated_at                | 2017-04-17T09:02:54                  |
+---------------------------+--------------------------------------+
[root@ansible devops]# neutron subnet-create pub-net2  \
>         --name   pub-subnet2 \
>         --allocation-pool start=172.31.250.1,end=172.31.250.210  \
>         --gateway=172.31.255.254 --enable_dhcp=False  \
>         --dns-nameserver 8.8.8.8 \
>         172.31.192.0/18
Created a new subnet:
+-------------------+----------------------------------------------------+
| Field             | Value                                              |
+-------------------+----------------------------------------------------+
| allocation_pools  | {"start": "172.31.250.1", "end": "172.31.250.210"} |
| cidr              | 172.31.192.0/18                                    |
| created_at        | 2017-04-17T09:02:55                                |
| description       |                                                    |
| dns_nameservers   | 8.8.8.8                                            |
| enable_dhcp       | False                                              |
| gateway_ip        | 172.31.255.254                                     |
| host_routes       |                                                    |
| id                | 91efb5fb-92e8-4ca5-a7cc-0090a0bc9dc0               |
| ip_version        | 4                                                  |
| ipv6_address_mode |                                                    |
| ipv6_ra_mode      |                                                    |
| name              | pub-subnet2                                        |
| network_id        | 1bcf1008-c001-42cc-8f99-6a663017b150               |
| subnetpool_id     |                                                    |
| tenant_id         | 7de3dec9204e4f52b704f391cd4413c4                   |
| updated_at        | 2017-04-17T09:02:55                                |
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


neutron router-gateway-set 7cfc6848-e004-402d-9677-ccfcf92ddf2e 1bcf1008-c001-42cc-8f99-6a663017b150
Set gateway for router 7cfc6848-e004-402d-9677-ccfcf92ddf2e

neutron router-gateway-clear 55c78fde-88ad-4b42-901f-80c307b2634c

neutron net-create priv-net-vxlan2

neutron subnet-create --name priv-subnet-vxlan2 \
                --enable_dhcp=True \
                --shared=True
                priv-net-vxlan2 10.12.0.0/16

[root@ansible devops]# neutron net-create priv-net-vxlan2
Created a new network:
+---------------------------+--------------------------------------+
| Field                     | Value                                |
+---------------------------+--------------------------------------+
| admin_state_up            | True                                 |
| availability_zone_hints   |                                      |
| availability_zones        |                                      |
| created_at                | 2017-04-17T10:26:08                  |
| description               |                                      |
| id                        | 5cada35f-a757-460c-9fe9-8f78abe0e62b |
| ipv4_address_scope        |                                      |
| ipv6_address_scope        |                                      |
| mtu                       | 1450                                 |
| name                      | priv-net-vxlan2                      |
| provider:network_type     | vxlan                                |
| provider:physical_network |                                      |
| provider:segmentation_id  | 87                                   |
| router:external           | False                                |
| shared                    | False                                |
| status                    | ACTIVE                               |
| subnets                   |                                      |
| tags                      |                                      |
| tenant_id                 | 7de3dec9204e4f52b704f391cd4413c4     |
| updated_at                | 2017-04-17T10:26:08                  |
+---------------------------+--------------------------------------+

[root@ansible devops]# neutron subnet-create --name priv-subnet-vxlan2 \
>                 --enable_dhcp=True \
>                 priv-net-vxlan2 10.12.0.0/16
Created a new subnet:
+-------------------+------------------------------------------------+
| Field             | Value                                          |
+-------------------+------------------------------------------------+
| allocation_pools  | {"start": "10.12.0.2", "end": "10.12.255.254"} |
| cidr              | 10.12.0.0/16                                   |
| created_at        | 2017-04-17T10:26:09                            |
| description       |                                                |
| dns_nameservers   |                                                |
| enable_dhcp       | True                                           |
| gateway_ip        | 10.12.0.1                                      |
| host_routes       |                                                |
| id                | a2c19f8e-eace-4396-b21b-98ffad3fa295           |
| ip_version        | 4                                              |
| ipv6_address_mode |                                                |
| ipv6_ra_mode      |                                                |
| name              | priv-subnet-vxlan2                             |
| network_id        | 5cada35f-a757-460c-9fe9-8f78abe0e62b           |
| subnetpool_id     |                                                |
| tenant_id         | 7de3dec9204e4f52b704f391cd4413c4               |
| updated_at        | 2017-04-17T10:26:09                            |
+-------------------+------------------------------------------------+

neutron router-interface-add   7cfc6848-e004-402d-9677-ccfcf92ddf2e a2c19f8e-eace-4396-b21b-98ffad3fa295 
Added interface ca4506c4-547f-4b09-839f-8cc16688f9ad to router 7cfc6848-e004-402d-9677-ccfcf92ddf2e.

neutron net-update  5cada35f-a757-460c-9fe9-8f78abe0e62b --shared=true
172.31.250.1 - 172.31.250.255
129.33.250.1 - 129.33.250.255

neutron subnet-update  91efb5fb-92e8-4ca5-a7cc-0090a0bc9dc0 --allocation-pool start=172.31.250.1,end=172.31.250.254
neutron net-create pub-net3   \
            --provider:network_type=vxlan \
            --provider:physical_network=ext-net2 \
        - --router:external=True  





neutron subnet-update  15b9c32d-621a-4bb8-8bfc-4ee33da419c5 --allocation-pool start=172.31.216.1,end=172.31.219.254 --allocation-pool start=172.31.250.240,end=172.31.250.248

neutron subnet-update  d21c0ced-29cf-4686-83ee-35041275b991 --allocation-pool start=172.31.250.1,end=172.31.250.239


[root@ctl-n1 ~]# neutron subnet-list
+--------------------------------------+---------------------------------------------------+------------------+--------------------------------------------------------+
| id                                   | name                                              | cidr             | allocation_pools                                       |
+--------------------------------------+---------------------------------------------------+------------------+--------------------------------------------------------+
| d0f38f67-1cac-4645-baf5-c518c073130f | HA subnet tenant dc9ac7739b4e4f78847ebad7f4b01614 | 169.254.192.0/18 | {"start": "169.254.192.1", "end": "169.254.255.254"}   |
| a2c19f8e-eace-4396-b21b-98ffad3fa295 | priv-subnet-vxlan2                                | 10.12.0.0/16     | {"start": "10.12.0.2", "end": "10.12.255.254"}         |
| f4eb3420-c5f6-4c6f-a9c0-cfe340a4a56e | baremetal-private-subnet                          | 192.168.128.0/18 | {"start": "192.168.128.161", "end": "192.168.128.171"} |
| 0ae1763c-5607-4ab8-8334-7c0ae6ce8c91 | HA subnet tenant qa                               | 169.254.192.0/18 | {"start": "169.254.192.1", "end": "169.254.255.254"}   |
| 8df08f76-e6db-480a-b882-de3538be479c | HA subnet tenant test                             | 169.254.192.0/18 | {"start": "169.254.192.1", "end": "169.254.255.254"}   |
| 38247e2a-0fed-4e19-98e7-61a6305c5073 | HA subnet tenant 7de3dec9204e4f52b704f391cd4413c4 | 169.254.192.0/18 | {"start": "169.254.192.1", "end": "169.254.255.254"}   |
| 2f99bebf-c721-463b-b971-35a510aaa01b | qa_subnet                                         | 10.17.0.0/24     | {"start": "10.17.0.2", "end": "10.17.0.254"}           |
| 15b9c32d-621a-4bb8-8bfc-4ee33da419c5 | pub-subnet1                                       | 172.31.192.0/18  | {"start": "172.31.216.1", "end": "172.31.219.254"}     |
|                                      |                                                   |                  | {"start": "172.31.250.240", "end": "172.31.250.248"}   |
| be54a337-2620-45a2-bc76-12abe3df2043 | subnet_prod                                       | 10.15.0.0/24     | {"start": "10.15.0.2", "end": "10.15.0.254"}           |
| d3a51b71-cf66-4076-a142-ab810132bd8c | priv-subnet-vxlan1                                | 10.11.0.0/16     | {"start": "10.11.0.2", "end": "10.11.255.254"}         |
| 7dcdcfd6-c8de-4416-9568-fcc1e4d9663b | test_subnet                                       | 10.16.0.0/24     | {"start": "10.16.0.2", "end": "10.16.0.254"}           |
| d21c0ced-29cf-4686-83ee-35041275b991 | pub-subnet2                                       | 172.31.192.0/18  | {"start": "172.31.250.2", "end": "172.31.250.254"}     |
+--------------------------------------+---------------------------------------------------+------------------+--------------------------------------------------------+
j

