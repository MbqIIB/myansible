#!/bin/bash

# Define log 
TIMESTAMP=`date +%Y%m%d%H%M%S` 
LOGDIR=log
LOG=call_sql_${TIMESTAMP}.log 
echo "Start execute sql statement at `date`." >> ${LOGDIR}/${LOG} 


tenant_id=892c4ca156184ec0ba61cd17cb6513da
user_id=78e9c02c215242c68cf2a78bf5fe8d87


#| c303a478-4608-4003-a9a2-acb4645c79c4 | BluePluse-redpower3-kvm.4c16g100G-xiaoyan             | ACTIVE  | -          | Running     | ent_vlan=192.168.32.162, 172.16.0.136                            |
#| 3828ccd5-4f94-4ac7-85e1-db0258febd37 | BluePluse-redpower3-kvm.4c16g20G-n1                   | ACTIVE  | -          | Running     | ent_vlan=192.168.32.160, 172.16.0.134                            |
#| c528f09a-0d99-45c2-866f-3b1f94932c79 | BluePluse-redpower3-kvm.6c32g20G-n0                   | ACTIVE  | -          | Running     | ent_vlan=192.168.32.161, 172.16.0.135 

#uuid=c303a478-4608-4003-a9a2-acb4645c79c4
#internalip=192.168.32.162
#floatingip=172.16.0.136

#uuid=3828ccd5-4f94-4ac7-85e1-db0258febd37
#internalip=192.168.32.160
#floatingip=172.16.0.134

uuid=c528f09a-0d99-45c2-866f-3b1f94932c79
internalip=192.168.32.161
floatingip=172.16.0.135

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


