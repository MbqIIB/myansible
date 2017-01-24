#!/bin/bash


set -x

dir=$1
#curdir=`pwd`

DATETIME=$(date  '+%Y%m%d_%H%M%S')
host=$(hostname -s)
logname=dockerimagelist${DATETIME}_${host}
docker images > ${logname}
scp ${logname}  ansible:${dir}
