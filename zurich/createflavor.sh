#!/bin/bash

source /root/openrc

set -x

#  #FLAVORNAME="smt2c.1s1c2t8g100G"
#  FLAVORNAME="docker.2c8g100G"
#  nova flavor-create ${FLAVORNAME} auto 8192 100 2
#  nova flavor-key    ${FLAVORNAME} set hw:cpu_sockets=1 hw:cpu_cores=1 hw:cpu_threads=2
#  nova flavor-show   ${FLAVORNAME}


#FLAVORNAME="smt4c.1s1c4t32g100G"
#nova flavor-create ${FLAVORNAME} auto 32768 100 4
#nova flavor-key    ${FLAVORNAME} set hw:cpu_sockets=1 hw:cpu_cores=1 hw:cpu_threads=4
#nova flavor-show   ${FLAVORNAME}


#FLAVORNAME="smt2c.1s1c2t16g100G"
#nova flavor-create ${FLAVORNAME} auto 16384 100 2
#nova flavor-key    ${FLAVORNAME} set hw:cpu_sockets=1 hw:cpu_cores=1 hw:cpu_threads=2
#nova flavor-show   ${FLAVORNAME}
#



#FLAVORNAME=smt8c.1s1c8t32g200G
#nova flavor-create ${FLAVORNAME} auto 32768 200 8
#nova flavor-key    ${FLAVORNAME} set hw:cpu_sockets=1 hw:cpu_cores=1 hw:cpu_threads=8
#nova flavor-show   ${FLAVORNAME}

FLAVORNAME="smt4c.1s1c4t32g500G"
nova flavor-create ${FLAVORNAME} auto 32768 500 4
nova flavor-key    ${FLAVORNAME} set hw:cpu_sockets=1 hw:cpu_cores=1 hw:cpu_threads=4
nova flavor-show   ${FLAVORNAME}


