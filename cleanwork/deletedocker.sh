#!/bin/bash

set -x
name=$1

while true
do
      docker rmi ${name} | grep  "TLS-enabled"
    if [ $? != 0 ];then
        echo "Del ${name} Success"
	break
    else
        echo "Del ${name} again"
    fi

done
