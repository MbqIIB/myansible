#!/bin/bash

# Define log 
TIMESTAMP=`date +%Y%m%d%H%M%S` 
LOGDIR=log
LOG=call_sql_${TIMESTAMP}.log 
echo "Start execute sql statement at `date`." >> ${LOGDIR}/${LOG} 


tenant_id=8a8d02dea2094627b1bcc0bbc34ef9f4
user_id=c959352c409a491a8117248e7ef8b787


#uuid=1a66747b-1ff9-4c28-b448-a5682ebcdbfb
#internalip=192.168.32.143
#floatingip=172.16.0.115


#uuid=8e759795-df46-4617-83ac-d6503c79f1a0
#internalip=192.168.32.142
#floatingip=172.16.0.114


uuid=417d8900-cf88-4154-8fa2-9948c0ef9ad0
internalip=192.168.32.231
floatingip=172.16.0.100



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


floatingport=$(neutron port-list | grep "${floatingip}" |  awk -F ' ' '{print $2}')
cmd="select * from neutron.ports where id='${floatingport}';"
mysql -e "${cmd}"  -popenstack1

cmd="update neutron.ports set tenant_id='${tenant_id}' where id='${floatingport}';"
mysql -e "${cmd}"  -popenstack1


#floatingport=4c426323-34e2-4a25-9b6a-526fdb682b83
#mysql -e 'select * from neutron.ports where id="4c426323-34e2-4a25-9b6a-526fdb682b83";' -popenstack1
#mysql -e 'update neutron.ports set tenant_id="592e63477f2b49b89234d745cfa7ed53" where id="4c426323-34e2-4a25-9b6a-526fdb682b83";' -popenstack1

floatingipid=$(neutron floatingip-list | grep "${floatingip}" |  awk -F ' ' '{print $2}')
cmd="select * from neutron.floatingips where id='${floatingipid}';"
mysql -e "${cmd}"  -popenstack1

cmd="update neutron.floatingips set tenant_id='${tenant_id}' where id='${floatingipid}';"
mysql -e "${cmd}"  -popenstack1


#cindervolumeid=87802f47-f21b-4d5f-811b-25143af10e5c
#mysql -e 'select user_id,project_id,size from cinder.volumes where id="87802f47-f21b-4d5f-811b-25143af10e5c";' -popenstack1
#mysql -e 'update cinder.volumes set user_id="d64260e45e6545ada6273e74409719f5"    where id="87802f47-f21b-4d5f-811b-25143af10e5c";' -popenstack1
#mysql -e 'update cinder.volumes set project_id="592e63477f2b49b89234d745cfa7ed53" where id="87802f47-f21b-4d5f-811b-25143af10e5c";' -popenstack1
#
#
