#!/bin/bash - 
#===============================================================================
#
#          FILE: clearfloatingip.sh
# 
#         USAGE: ./clearfloatingip.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2015年09月14日 09时11分27秒 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


allip=$(nova floating-ip-list | grep " - " | awk -F " " '{print $2}')


for ip in ${allip[@]}
do
    echo "$ip"
    nova floating-ip-delete $ip
done


echo "==========now=========="
nova floating-ip-list
