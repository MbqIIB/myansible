#!/bin/bash

alldb=( 			\
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
#filepath="${backup_dir}/${dbname}-${dbfilesuffix}"
#	echo ${filepath}

#/usr/bin/mysqldump -uroot -p123456 --opt ${dbname} | gzip > ${filepath}

        if [ ${dbname} == "keystone" ]
        then
            echo " ----------------name is : ${dbname}"
        else
            echo " name is : ${dbname}"
        fi
done


