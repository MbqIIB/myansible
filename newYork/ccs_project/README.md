

pcs cluster start poc-ctl0
pcs cluster start poc-ctl1
pcs cluster start poc-ctl2


/usr/bin/galera_new_cluster

pcs resource
pcs cluster unstandby --all


  355  2016-11-15 03:46:58 scp setupctl.sh poc-ctl1:/root/scripts/
  356  2016-11-15 03:46:58 scp setupctl.sh poc-ctl2:/root/scripts/
  357  2016-11-15 03:46:58 ls
  358  2016-11-15 03:46:58 mysql -u root -e "SHOW STATUS LIKE 'wsrep%';"
  359  2016-11-15 03:46:58 pcs cluster auth poc-ctl0 poc-ctl1 poc-ctl2
  360  2016-11-15 03:46:58 pcs cluster setup --start --name openstack_cluster poc-ctl0 poc-ctl1 poc-ctl2
/cluster                                                                                                     






[root@ctl-rhel ~]# neutron net-create pub-net1         -- --router:external=True
+---------------------------+--------------------------------------+
| Field                     | Value                                |
+---------------------------+--------------------------------------+
| admin_state_up            | True                                 |
| availability_zone_hints   |                                      |
| availability_zones        |                                      |
| created_at                | 2016-11-22T06:25:46                  |
| description               |                                      |
| id                        | 431c4194-409e-410d-9e06-9712108b9a24 |
| ipv4_address_scope        |                                      |
| ipv6_address_scope        |                                      |
| is_default                | False                                |
| mtu                       | 1450                                 |
| name                      | pub-net1                             |
| provider:network_type     | vxlan                                |
| provider:physical_network |                                      |
| provider:segmentation_id  | 101                                  |
| router:external           | True                                 |
| shared                    | False                                |
| status                    | ACTIVE                               |
| subnets                   |                                      |
| tags                      |                                      |
| tenant_id                 | 8a7a6db0f993449badb39e622c27fc07     |
| updated_at                | 2016-11-22T06:25:46                  |
+---------------------------+--------------------------------------+


neutron subnet-create pub-net1  --allocation-pool start=9.2.133.244,end=9.2.133.254  \
               --gateway=9.2.133.130 --enable_dhcp=False  \
               9.2.133.130/25

Created a new subnet:
+-------------------+------------------------------------------------+
| Field             | Value                                          |
+-------------------+------------------------------------------------+
| allocation_pools  | {"start": "9.2.133.244", "end": "9.2.133.254"} |
| cidr              | 9.2.133.128/25                                 |
| created_at        | 2016-11-22T06:35:47                            |
| description       |                                                |
| dns_nameservers   |                                                |
| enable_dhcp       | False                                          |
| gateway_ip        | 9.2.133.130                                    |
| host_routes       |                                                |
| id                | 1d7710c7-5bef-47bf-9664-89316e3b7577           |
| ip_version        | 4                                              |
| ipv6_address_mode |                                                |
| ipv6_ra_mode      |                                                |
| name              |                                                |
| network_id        | 431c4194-409e-410d-9e06-9712108b9a24           |
| subnetpool_id     |                                                |
| tenant_id         | 8a7a6db0f993449badb39e622c27fc07               |
| updated_at        | 2016-11-22T06:35:47                            |
+-------------------+------------------------------------------------+

neutron router-create pub-router
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
| ha                      | False                                |
| id                      | c216f2f0-e87d-4398-9532-74d5ad2bec5a |
| name                    | pub-router                           |
| routes                  |                                      |
| status                  | ACTIVE                               |
| tenant_id               | 8a7a6db0f993449badb39e622c27fc07     |
+-------------------------+--------------------------------------+

neutron router-gateway-set c216f2f0-e87d-4398-9532-74d5ad2bec5a 431c4194-409e-410d-9e06-9712108b9a24
Set gateway for router c216f2f0-e87d-4398-9532-74d5ad2bec5a

neutron net-create priv-net-vlan1  

Created a new network:
+---------------------------+--------------------------------------+
| Field                     | Value                                |
+---------------------------+--------------------------------------+
| admin_state_up            | True                                 |
| availability_zone_hints   |                                      |
| availability_zones        |                                      |
| created_at                | 2016-11-22T06:47:34                  |
| description               |                                      |
| id                        | 4cf20833-94ef-4a9f-afb5-4753485deea9 |
| ipv4_address_scope        |                                      |
| ipv6_address_scope        |                                      |
| mtu                       | 1450                                 |
| name                      | priv-net-vlan1                       |
| provider:network_type     | vxlan                                |
| provider:physical_network |                                      |
| provider:segmentation_id  | 103                                  |
| router:external           | False                                |
| shared                    | False                                |
| status                    | ACTIVE                               |
| subnets                   |                                      |
| tags                      |                                      |
| tenant_id                 | 8a7a6db0f993449badb39e622c27fc07     |
| updated_at                | 2016-11-22T06:47:35                  |
+---------------------------+--------------------------------------+

neutron subnet-create pub-net1  --allocation-pool start=9.2.133.244,end=9.2.133.254  \
               --gateway=9.2.133.130 --enable_dhcp=False  \
neutron subnet-create --name priv-subnet-vxlan1 \
              --enable_dhcp=True \
	      priv-net-vlan1 10.100.0.0/16


+-------------------+--------------------------------------------------+
| Field             | Value                                            |
+-------------------+--------------------------------------------------+
| allocation_pools  | {"start": "10.100.0.2", "end": "10.100.255.254"} |
| cidr              | 10.100.0.0/16                                    |
| created_at        | 2016-11-22T06:59:47                              |
| description       |                                                  |
| dns_nameservers   |                                                  |
| enable_dhcp       | True                                             |
| gateway_ip        | 10.100.0.1                                       |
| host_routes       |                                                  |
| id                | fde8abfa-5c64-4b97-950f-24707860c281             |
| ip_version        | 4                                                |
| ipv6_address_mode |                                                  |
| ipv6_ra_mode      |                                                  |
| name              | priv-subnet-vxlan1                               |
| network_id        | 4cf20833-94ef-4a9f-afb5-4753485deea9             |
| subnetpool_id     |                                                  |
| tenant_id         | 8a7a6db0f993449badb39e622c27fc07                 |
| updated_at        | 2016-11-22T06:59:47                              |
+-------------------+--------------------------------------------------+


neutron router-interface-add c216f2f0-e87d-4398-9532-74d5ad2bec5a fde8abfa-5c64-4b97-950f-24707860c281

Added interface 447f4aa8-0cbf-460d-9633-ac874e672f5e to router c216f2f0-e87d-4398-9532-74d5ad2bec5a















