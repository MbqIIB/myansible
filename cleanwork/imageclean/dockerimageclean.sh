#!/bin/bash - 
#===============================================================================
#
#          FILE: dockerimageclean.sh
# 
#         USAGE: ./dockerimageclean.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04/26/2017 11:36:09 AM CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


maindir=/opt/servicemonitor
pushd $maindir
/usr/bin/ansible compute-server-docker -m script  -a 'cpDockerImagesClean.sh'
popd

