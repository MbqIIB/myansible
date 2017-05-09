#!/bin/bash

tenant_id=592e63477f2b49b89234d745cfa7ed53
user_id=d64260e45e6545ada6273e74409719f5
uuid=6f42ec88-b392-4aa2-95be-d8ef47209e13



#mysql -e 'select * from nova.instances' -popenstack1

#mysql -e 'select id,uuid,user_id,project_id,node from nova.instances where uuid="6f42ec88-b392-4aa2-95be-d8ef47209e13";' -popenstack1

mysql -e 'select id,uuid,user_id,project_id,node from nova.instances where uuid="6f42ec88-b392-4aa2-95be-d8ef47209e13";' -popenstack1
mysql -e 'update nova.instances set user_id="d64260e45e6545ada6273e74409719f5"    where uuid="6f42ec88-b392-4aa2-95be-d8ef47209e13";' -popenstack1
mysql -e 'update nova.instances set project_id="592e63477f2b49b89234d745cfa7ed53" where uuid="6f42ec88-b392-4aa2-95be-d8ef47209e13";' -popenstack1



#port
#nova show 6f42ec88-b392-4aa2-95be-d8ef47209e13
#| 4c426323-34e2-4a25-9b6a-526fdb682b83 |      | fa:16:3e:2b:f1:4b | {"subnet_id": "66925789-515a-406d-84c3-89acdc28d52b", "ip_address": "172.16.0.229"}   |
#| 5768cc9a-4d81-47ef-9a60-29d13b5fdede |      | fa:16:3e:0c:be:dc | {"subnet_id": "585b7e7e-e890-4b4b-90f9-e877605f5d5e", "ip_address": "192.168.33.2"}   |



internalport=5768cc9a-4d81-47ef-9a60-29d13b5fdede
mysql -e 'select * from neutron.ports where id="5768cc9a-4d81-47ef-9a60-29d13b5fdede";' -popenstack1
mysql -e 'update neutron.ports set tenant_id="592e63477f2b49b89234d745cfa7ed53" where id="5768cc9a-4d81-47ef-9a60-29d13b5fdede";' -popenstack1

floatingport=4c426323-34e2-4a25-9b6a-526fdb682b83
mysql -e 'select * from neutron.ports where id="4c426323-34e2-4a25-9b6a-526fdb682b83";' -popenstack1
mysql -e 'update neutron.ports set tenant_id="592e63477f2b49b89234d745cfa7ed53" where id="4c426323-34e2-4a25-9b6a-526fdb682b83";' -popenstack1




cindervolumeid=87802f47-f21b-4d5f-811b-25143af10e5c
mysql -e 'select user_id,project_id,size from cinder.volumes where id="87802f47-f21b-4d5f-811b-25143af10e5c";' -popenstack1
mysql -e 'update cinder.volumes set user_id="d64260e45e6545ada6273e74409719f5"    where id="87802f47-f21b-4d5f-811b-25143af10e5c";' -popenstack1
mysql -e 'update cinder.volumes set project_id="592e63477f2b49b89234d745cfa7ed53" where id="87802f47-f21b-4d5f-811b-25143af10e5c";' -popenstack1


###########################################################################################
#select * from ports where id="a21e03bf-f49a-46bd-920d-a9086e93dc09";
#update ports set tenant_id="592e63477f2b49b89234d745cfa7ed53" where id="a21e03bf-f49a-46bd-920d-a9086e93dc09";
#select * from ports where id="32feac16-1fc5-41d6-9be6-0717157c787f";
#select * from ports where id="60a1d88f-c178-445b-a40a-0672fc58013d";
#update ports set tenant_id="592e63477f2b49b89234d745cfa7ed53" where id="60a1d88f-c178-445b-a40a-0672fc58013d";
#

##use neutron
##show tables;
##select
#;
#desc ports;
#select * from ports;
#select * from ports where id="a21e03bf-f49a-46bd-920d-a9086e93dc09";
#update ports set tenant_id="592e63477f2b49b89234d745cfa7ed53" where id="a21e03bf-f49a-46bd-920d-a9086e93dc09";
#select * from ports where id="32feac16-1fc5-41d6-9be6-0717157c787f";
#select * from ports where id="60a1d88f-c178-445b-a40a-0672fc58013d";
#update ports set tenant_id="592e63477f2b49b89234d745cfa7ed53" where id="60a1d88f-c178-445b-a40a-0672fc58013d";
#show tables;
#desc floatingips;
#select * from floatingips where id="32feac16-1fc5-41d6-9be6-0717157c787f";
#update floatingips set tenant_id="592e63477f2b49b89234d745cfa7ed53" where id="32feac16-1fc5-41d6-9be6-0717157c787f";
#use cinder;
#show tables;
#select * from volumes;
#desc volumes;
#select * from volumes where id=" 87802f47-f21b-4d5f-811b-25143af10e5c";
#select id from volumes;
#select * from volumes where id="533b3bae-96a5-4348-8600-69deb6c54f23";
#select * from volumes where id="87802f47-f21b-4d5f-811b-25143af10e5c";
#
