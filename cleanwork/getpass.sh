#!/bin/bash

set -x
maillist=$(awk -F ' ' '{print $6}' allstacklist.log )

for mail in ${maillist[@]}
do
	tid=$(grep $mail alltenantlist.txt)
        if [ $? != 0 ];then
			echo "$mail==xxxxxxxxxxxxxxxxxxxxxxx" >> pass.txt
		else
			echo "$tid" >> pass.txt
		fi
done
