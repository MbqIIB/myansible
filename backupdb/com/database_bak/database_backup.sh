#!/bin/bash

Hname=`hostname`
#DateTime=$(date -u +%Y%m%d_%H%M%S)
DateTime=$(date +%Y%m%d_%H%M%S)
days=30
backupmain_dir="/os-image1/OpenPowerDataBak"
backup_dir="${backupmain_dir}/DataBak-${Hname}-${DateTime}"

dbfilesuffix="mysql-${DateTime}.sql.gz"

tmp_config_dir="${backup_dir}/config"
config_filename="${backup_dir}/config.tar.gz"
echo ${tmp_config_dir}
echo ${config_filename}

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


alldb=( 			\
		mysql      		\
		cinder      		\
		glance      		\
		heat        		\
		keystone    		\
		nova        		\
		neutron 		)


for dbname  in ${alldb[@]}
do
	echo "backup ${dbname} ... "
	# Dump the entire MySQL database
	filepath="${backup_dir}/${dbname}-${dbfilesuffix}"
	echo ${filepath}
        
        if [ ${dbname} == "keystone" ]
        then
	    /usr/bin/mysqldump -uroot -pyourpass -h 192.168.11.51 --opt ${dbname} | gzip > ${filepath}
        else
	    /usr/bin/mysqldump -uroot -pyourpass --opt ${dbname} | gzip > ${filepath}
        fi

done

# Copy configuration files to the backup directory
mkdir -p ${tmp_config_dir}
echo "backup ${config_filename} ... "

cp -a /etc/nova ${tmp_config_dir}/.
cp -a /etc/neutron ${tmp_config_dir}/.
cp -a /etc/glance ${tmp_config_dir}/.
cp -a /etc/keystone ${tmp_config_dir}/.
cp -a /etc/ceilometer ${tmp_config_dir}/.
tar czf ${config_filename} ${tmp_config_dir}
rm -fr ${tmp_config_dir}

#scp.sh
host="9.186.88.208"
username="crluser"
password="passw0rd"
src=${backup_dir}
dst="/data/OpenpowerDataBak"

#/home/linzhbj/openpower/database_bak/autoscp.sh ${host} ${username} ${password} ${src} ${dst}

# Delete backups older than 7 days
find $backup_dir -ctime +${days} -type f -delete

#find /os-image1/OpenPowerDataBak/ -type d -name "DataBak-*" -ctime +7
filelist=`find ${backupmain_dir} -type d -name "DataBak-*" -mtime +${days} `
for file in ${filelist[@]}
do
	echo "Delete old data ... ${file}"
	rm -rf ${file}
done



#chown opadmin:opadmin  -R /os-image1/OpenPowerDataBak
chown opadmin:opadmin -R ${backupmain_dir}

echo "Done"

