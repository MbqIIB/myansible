#!/bin/bash
set -x

#srcdir=/var/lib/glance/images/
#srcdir=/var/lib/glance/images/image_bak/
#srcdir=/gpfs/gpfs_enterprise/linzhbj_image
#srcdir=/gpfs/linzhbj
srcdir=`pwd`


imagename=ubuntu_14_lts_docker_aufs_ppc64le_v0.1.0test
glance image-create --name=${imagename} \
                           --is-public=false \
                           --property architecture=ppc64le  \
                           --property accelerator_type=gpu_pcie \
                           --property hypervisor_type=docker \
                           --property os_type="Ubuntu14.04-ppc64le" \
                           --container-format=docker \
                           --property image_type=custom_image \
                           --property sys_type=ubuntu \
                           --property webshell=true \
                           --disk-format=raw \
                           --file  ${srcdir}/${imagename}.raw






#imagename=ubuntu_14_lts_docker_aufs_ppc64le_cuda7_tensorflow_v1.2
#glance image-create --name=${imagename} \
#                           --is-public=true \
#                           --property architecture=ppc64le  \
#                           --property accelerator_type=gpu_pcie \
#                           --property hypervisor_type=docker \
#                           --property os_type="Ubuntu14.04-ppc64le" \
#                           --container-format=docker \
#                           --property image_type=custom_image \
#                           --property sys_type=ubuntu \
#                           --property webshell=true \
#                           --disk-format=raw \
#                           --file  ${srcdir}/${imagename}.raw
#




#imagename=ubuntu_14_lts_docker_aufs_ppc64le_v0.1.0_wangjunsong_v1.0
#glance image-create --name=${imagename} \
#                           --is-public=true \
#                           --property architecture=ppc64le  \
#                           --property accelerator_type=none \
#                           --property hypervisor_type=docker \
#                           --property os_type="Ubuntu14.04-ppc64le" \
#                           --container-format=docker \
#                           --property image_type=custom_image \
#                           --property sys_type=ubuntu \
#                           --property webshell=true \
#                           --disk-format=raw \
#                           --file  ${srcdir}/${imagename}.raw

#imagename=ubuntu_14_lts_docker_aufs_ppc64le_ibmsdk_xlc_cuda_openblas_v1.0.3
#glance image-create --name=${imagename} \
#                           --is-public=true \
#                           --property architecture=ppc64le  \
#                           --property accelerator_type=none \
#                           --property hypervisor_type=docker \
#                           --property os_type="Ubuntu14.04-ppc64le" \
#                           --container-format=docker \
#                           --property image_type=custom_image \
#                           --property sys_type=ubuntu \
#                           --property webshell=true \
#                           --disk-format=raw \
#                           --file  ${srcdir}/${imagename}.raw



#imagename=centos_7.2_docker_aufs_x86_64_v1.0.2
#glance image-create --name=${imagename} \
#                           --is-public=true \
#                           --property architecture=x86_64  \
#                           --property accelerator_type=none \
#                           --property hypervisor_type=docker \
#                           --property os_type="CentOS-7.2-x86_64" \
#                           --container-format=docker \
#                           --property image_type=image \
#                           --property sys_type=centos \
#                           --property webshell=true \
#                           --disk-format=raw \
#                           --file  ${srcdir}/${imagename}.raw
#
#


#imagename=centos_7.2_docker_aufs_ppc64le_v1.0.2
#glance image-create --name=${imagename} \
#                           --is-public=true \
#                           --property architecture=ppc64le  \
#                           --property accelerator_type=none \
#                           --property hypervisor_type=docker \
#                           --property os_type="CentOS-7.2-ppc64le" \
#                           --container-format=docker \
#                           --property image_type=image \
#                           --property sys_type=centos \
#                           --property webshell=true \
#                           --disk-format=raw \
#                           --file  ${srcdir}/${imagename}.raw
#
#







#name=ubuntu_14.04.2_docker_aufs_x86_64_v0.0.2
#docker save ${name} | glance image-create \
#    --is-public=True \
#    --container-format=docker \
#    --disk-format=raw \
#    --name ${name} \
#    --property architecture=x86_64 \
#    --property hypervisor_type=docker \
#    --property sys_type=ubuntu \
#    --property image_type=image \
#    --property webshell=True \
#    --property os_type="Ubuntu-14.04.2-x86_64"
