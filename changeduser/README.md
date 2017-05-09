
mysql -e 'select hypervisor_hostname,supported_instances from nova.compute_nodes' -popenstack1
mysql -e 'delete from nova.compute_nodes where hypervisor_hostname="ent-cp7-ppc64le.ibm.com";' -popenstack1

nova.instances



nova show 6f42ec88-b392-4aa2-95be-d8ef47209e13
| 4c426323-34e2-4a25-9b6a-526fdb682b83 |      | fa:16:3e:2b:f1:4b | {"subnet_id": "66925789-515a-406d-84c3-89acdc28d52b", "ip_address": "172.16.0.229"}   |
| 5768cc9a-4d81-47ef-9a60-29d13b5fdede |      | fa:16:3e:0c:be:dc | {"subnet_id": "585b7e7e-e890-4b4b-90f9-e877605f5d5e", "ip_address": "192.168.33.2"}   |


linzhbj
userid=ece54c43f5bf4040a2804e2456c0a275
tenantid=4e29c5e6ebe74eb683fc5e34a6e7e89d





floatingip=1c9c3745-d7d4-435c-b8c5-c19d415fde71
mysql -e 'select * from neutron.floatingips where id="1c9c3745-d7d4-435c-b8c5-c19d415fde71";' -popenstack1




| c959352c409a491a8117248e7ef8b787 |                xuechao@cn.ibm.com               |   True  |                xuechao@cn.ibm.com               |
| 8a8d02dea2094627b1bcc0bbc34ef9f4 |                xuechao@cn.ibm.com               |   True  |
