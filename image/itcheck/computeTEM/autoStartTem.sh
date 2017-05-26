#!/bin/bash - 
#===============================================================================
#
#          FILE: autoInstallTem.sh
# 
#         USAGE: ./autoInstallTem.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 05/22/2017 05:53:04 PM CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#set -x

while true;
do
	ps -ef | grep -v "grep" | grep "BESClient"
	if [ $? == 0 ];then
      		echo "Have Start"
		break
	else
      		echo "Will Start"
		/etc/init.d/besclient start
		sleep 2
	fi
done


#ls -l /var/opt/BESClient/__BESData/__Global/Logs/
#tail -f /var/opt/BESClient/__BESData/__Global/Logs/20170522.log

rm -rf /tmp/itcheck*   /tmp/auto*Tem.sh
