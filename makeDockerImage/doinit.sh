#!/bin/bash

initdir=initscript
bash /bd_build/${initdir}

#rm -rf /home/opuser/capi_sample

#bash /bd_build/${initdir}/isoft_ppc64_env_init.sh
#bash /bd_build/${initdir}/redflag_ppc64_env_init.sh
#bash /bd_build/${initdir}/redflag_ppc64le_env_init.sh
#bash /bd_build/${initdir}/rhel7_env_init.sh
#bash /bd_build/${initdir}/rhel7_ppc64_env_init.sh
#bash /bd_build/${initdir}/rhel7_ppc64le_env_init_informix.sh
#bash /bd_build/${initdir}/rhel7_ppc64le_env_init.sh
#bash /bd_build/${initdir}/rhel7_x86_64_env_init.sh
#bash /bd_build/${initdir}/spark_rhel7_env_init.sh
#bash /bd_build/${initdir}/spark_rhel7_ppc64le_env_init.sh
#bash /bd_build/${initdir}/ubuntu14_env_init.sh
#bash /bd_build/${initdir}/ubuntu14_ppc64le_env_init_informix.sh
bash /bd_build/${initdir}/ubuntu14_ppc64le_env_init.sh
#bash /bd_build/${initdir}/ubuntu14_x86_64_env_init.sh

chage -d 0 opuser
chage -d 0 root

echo "Done"
