#!/bin/bash

set -x

Hname=`hostname`
DateTime=$(date +%Y%m%d_%H%M%S)
days=90
backupmain_dir="/svrepo/OpenPowerDataBak"
backup_dir="${backupmain_dir}/swift-${Hname}-${DateTime}"

RemoteIP=172.16.10.80
RemoteDir=/gpfs/gpfs_enterprise/BlueMix_Swiftbak


if [ ! -d ${backupmain_dir} ]
then
        echo "Create ${backupmain_dir}"
        mkdir ${backupmain_dir}
fi

if [ ! -d ${backup_dir} ]
then
        echo "Create ${backup_dir}"
        mkdir ${backup_dir}
fi



source /root/openrc

function download()
{
tenantname=$1
mkdir dir_${tenantname}
pushd dir_${tenantname}

swift download -a
#ls -l
popd
}

function setenv()
{
tenantname=$1
username=$1
password=$2
emailaddr=$3

export OS_USERNAME=${username}
export OS_PASSWORD=${password}
export OS_TENANT_NAME=${tenantname}

}

function vpnc_connect()
{
    /usr/sbin/vpnc /etc/vpnc/Power_048.conf

    if [ $? != 0 ];then
        exit 1
    fi
}

function pingtest ()
{
    ip=$1
    ping $ip  -c 2  -w 5
    if [ $? != 0 ];then
        echo " test ping $ip error"
        return
    fi
}


function scp2remote()
{
/usr/sbin/vpnc-disconnect
sleep 2
vpnc_connect
sleep 2
pingtest 172.16.10.80
scp -r ${backup_dir}.tar.gz root@${RemoteIP}:$RemoteDir
/usr/sbin/vpnc-disconnect
}

function ClearOldData
{
find ${backupmain_dir} -name "swift-*.tar.gz" -mtime +${days} -delete
}


passwdfile=/home/linzhbj/openpower/bak_swift/passwd.txt

### main ###
pushd ${backupmain_dir}

for user in `awk '{print $1}' ${passwdfile}`

do
    passwd=`awk -v I="$user" '{if(I==$1)print $2}' ${passwdfile}`
    email=`awk -v I="$user" '{if(I==$1)print $3}' ${passwdfile}`
    echo $user $passwd $email
    setenv $user $passwd $email

    pushd ${backup_dir}
    download $tenantname
    popd

done

tar czf ${backup_dir}.tar.gz ${backup_dir}
rm -rf  ${backup_dir}
popd

scp2remote

ClearOldData

#### end ####
