#!/bin/bash

set -x
maillist=$(awk -F '|' '{print $4}' vmlist )

for mail in ${maillist[@]}
do
    tid=$(grep $mail alltenantlist.txt)
    if [ $? != 0 ];then
        echo "$mail==xxxxxxxxxxxxxxxxxxxxxxx" >> mail.txt
    else
        echo "$tid" >> mail.txt
    fi
done
