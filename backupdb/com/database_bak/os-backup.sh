#!/bin/bash

backup_dir="/home/zhuchao/backup"
filename="${backup_dir}/mysql-`hostname`-`eval date +%Y%m%d`.sql.gz"

# Dump the entire MySQL database
/usr/bin/mysqldump -uroot -pyourpass --opt --all-databases | gzip > $filename

# Backup configurations
tmp_config_dir="${backup_dir}/config-`hostname`-`eval date +%Y%m%d`"
config_filename="${backup_dir}/config-`hostname`-`eval date +%Y%m%d`.tar.gz"

# Copy configuration files to the backup directory
mkdir -p ${tmp_config_dir}
cp -a /etc/nova ${tmp_config_dir}/.
cp -a /etc/neutron ${tmp_config_dir}/.
cp -a /etc/glance ${tmp_config_dir}/.
cp -a /etc/keystone ${tmp_config_dir}/.
cp -a /etc/ceilometer ${tmp_config_dir}/.
tar czf ${config_filename} ${tmp_config_dir}
rm -fr ${tmp_config_dir}

# Delete backups older than 7 days
find $backup_dir -ctime +7 -type f -delete
