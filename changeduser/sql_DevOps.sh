#!/bin/bash

# Define log 
TIMESTAMP=`date +%Y%m%d%H%M%S` 
LOGDIR=log
LOG=call_sql_${TIMESTAMP}.log 
echo "Start execute sql statement at `date`." >> ${LOGDIR}/${LOG} 


tenant_id=e9318dfd90c647d7bfd86343859224e0
user_id=ddeb80ddd4f14d60bbdff7b82835250a

# ac553c38-2fc7-45bb-8e82-f3108355f03a | DevOps-cp2-x86-kvm.2c4g20G-Chef_12.6                  | ACTIVE  | -          | Running     | ent_vlan=192.168.32.252, 172.16.0.220                            |
# e9daa0f5-2942-4c27-a60f-e19315fff28e | DevOps-cp2-x86-kvm.2c4g20G-DB2_v10                    | ACTIVE  | -          | Running     | ent_vlan=192.168.32.250, 172.16.0.218                            |
# 18f4ab79-e28d-4c74-8d39-742283e90d67 | DevOps-cp2-x86-kvm.2c4g20G-Jenkins_1.64               | ACTIVE  | -          | Running     | ent_vlan=192.168.32.251, 172.16.0.219                            |
# 71ac78ae-0180-40c9-a041-5d7ba7bdfa72 | DevOps-cp2-x86-kvm.2c4g20G-Tomcat7_MongoDB3.2         | ACTIVE  | -          | Running     | ent_vlan=192.168.32.249, 172.16.0.217; management=192.168.16.167 |
# 67d7d179-336a-43cd-8be3-988a2b30373a | DevOps-cp2-x86-kvm.2c4g20G-UCDP                       | ACTIVE  | -          | Running     | ent_vlan=192.168.32.253, 172.16.0.221                        

#uuid=ac553c38-2fc7-45bb-8e82-f3108355f03a
#internalip=192.168.32.252
#floatingip=172.16.0.220

#uuid=e9daa0f5-2942-4c27-a60f-e19315fff28e
#internalip=192.168.32.250
#floatingip=172.16.0.218

#uuid=18f4ab79-e28d-4c74-8d39-742283e90d67
#internalip=192.168.32.251
#floatingip=172.16.0.219

#uuid=67d7d179-336a-43cd-8be3-988a2b30373a
#internalip=192.168.32.253
#floatingip=172.16.0.221

uuid=71ac78ae-0180-40c9-a041-5d7ba7bdfa72
internalip=192.168.32.249
floatingip=172.16.0.217
manageip=192.168.16.167

set -x
cmd="select id,uuid,user_id,project_id,node from nova.instances where uuid='${uuid}';"
echo "$cmd"
mysql -e "${cmd}"  -popenstack1

cmd="update nova.instances set user_id='${user_id}' where uuid='${uuid}';"
echo "$cmd"
mysql -e "${cmd}"  -popenstack1

cmd="update nova.instances set project_id='${tenant_id}' where uuid='${uuid}';"
echo "$cmd"
mysql -e "${cmd}"  -popenstack1


#mysql -e 'select id,uuid,user_id,project_id,node from nova.instances where uuid="c8072814-e1e4-4e6d-b002-4ab4721b3a2a";' -popenstack1
#mysql -e 'update nova.instances set user_id="d64260e45e6545ada6273e74409719f5"    where uuid="6f42ec88-b392-4aa2-95be-d8ef47209e13";' -popenstack1
#mysql -e 'update nova.instances set project_id="592e63477f2b49b89234d745cfa7ed53" where uuid="6f42ec88-b392-4aa2-95be-d8ef47209e13";' -popenstack1


##### manageport=$(neutron port-list | grep "\"${manageip}\"" | awk -F ' ' '{print $2}')
##### echo "$manageport"
##### cmd="select * from neutron.ports where id='${manageport}';"
##### mysql -e "${cmd}"  -popenstack1
##### 
##### cmd="update neutron.ports set tenant_id='${tenant_id}' where id='${manageport}';"
##### mysql -e "${cmd}"  -popenstack1



internalport=$(neutron port-list | grep "${internalip}" | awk -F ' ' '{print $2}')
echo "$internalport"
cmd="select * from neutron.ports where id='${internalport}';"
mysql -e "${cmd}"  -popenstack1

cmd="update neutron.ports set tenant_id='${tenant_id}' where id='${internalport}';"
mysql -e "${cmd}"  -popenstack1


#mysql -e 'select * from neutron.ports where id="5768cc9a-4d81-47ef-9a60-29d13b5fdede";' -popenstack1
#mysql -e 'update neutron.ports set tenant_id="592e63477f2b49b89234d745cfa7ed53" where id="5768cc9a-4d81-47ef-9a60-29d13b5fdede";' -popenstack1


floatingport=$(neutron port-list | grep "\"${floatingip}\"" |  awk -F ' ' '{print $2}')
cmd="select * from neutron.ports where id='${floatingport}';"
mysql -e "${cmd}"  -popenstack1

cmd="update neutron.ports set tenant_id='${tenant_id}' where id='${floatingport}';"
mysql -e "${cmd}"  -popenstack1


#floatingport=4c426323-34e2-4a25-9b6a-526fdb682b83
#mysql -e 'select * from neutron.ports where id="4c426323-34e2-4a25-9b6a-526fdb682b83";' -popenstack1
#mysql -e 'update neutron.ports set tenant_id="592e63477f2b49b89234d745cfa7ed53" where id="4c426323-34e2-4a25-9b6a-526fdb682b83";' -popenstack1

floatingipid=$(neutron floatingip-list | grep "| ${floatingip} " |  awk -F ' ' '{print $2}')
cmd="select * from neutron.floatingips where id='${floatingipid}';"
mysql -e "${cmd}"  -popenstack1

cmd="update neutron.floatingips set tenant_id='${tenant_id}' where id='${floatingipid}';"
mysql -e "${cmd}"  -popenstack1


#cindervolumeid=87802f47-f21b-4d5f-811b-25143af10e5c
#mysql -e 'select user_id,project_id,size from cinder.volumes where id="87802f47-f21b-4d5f-811b-25143af10e5c";' -popenstack1
#mysql -e 'update cinder.volumes set user_id="d64260e45e6545ada6273e74409719f5"    where id="87802f47-f21b-4d5f-811b-25143af10e5c";' -popenstack1
#mysql -e 'update cinder.volumes set project_id="592e63477f2b49b89234d745cfa7ed53" where id="87802f47-f21b-4d5f-811b-25143af10e5c";' -popenstack1

volumeid=$(cinder list | grep "${uuid}" | awk -F ' ' '{print $2}')
if [ "X${volumeid}" == "X" ];then
	exit 1
fi

cmd="select user_id,project_id,size from cinder.volumes where id='${volumeid}';"
echo "$cmd"
mysql -e "${cmd}"  -popenstack1

cmd="update cinder.volumes set user_id='${user_id}' where id='${volumeid}';"
echo "$cmd"
mysql -e "${cmd}"  -popenstack1

cmd="update cinder.volumes set project_id='${tenant_id}' where id='${volumeid}';"
echo "$cmd"
mysql -e "${cmd}"  -popenstack1


