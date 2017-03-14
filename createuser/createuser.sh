#!/bin/bash

set -x

#tenantname="t2@cn.ibm.com"
#username=${tenantname}
#password="passw0rd"
#emailaddr=${username}

source /root/openrc

function createuser()
{
tenantname=$1
username=$1
password=$2
emailaddr=$3

tenantid=$(keystone tenant-create  \
	--name ${tenantname}  \
	--description "${tenantname}" \
	--enabled true | grep " id " | awk -F " " '{print $4}')

echo "${tenantid}"

keystone  user-create  --name ${username} --pass ${password}  --tenant ${tenantid} --email ${emailaddr} --enabled true

}

function addport()
{
export OS_TENANT_NAME=$1
export OS_USERNAME=$1
export OS_PASSWORD=$2

nova secgroup-list-rules default
nova secgroup-add-rule default icmp -1 -1 0.0.0.0/0
nova secgroup-add-rule default tcp 22 22 0.0.0.0/0
nova secgroup-add-rule default tcp 4200 4200 0.0.0.0/0
nova secgroup-list-rules default


}

passwdfile=passwdfile.txt

for user in `awk '{print $1}' ${passwdfile}`

do

    passwd=`awk -v I="$user" '{if(I==$1)print $2}' ${passwdfile}`
    email=`awk -v I="$user" '{if(I==$1)print $3}' ${passwdfile}`

    echo $user $passwd $email
    createuser $user $passwd $email
    addport $user $passwd $email

done

