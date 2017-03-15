#!/bin/bash
set -x
#name=ubuntu_14_lts_docker_aufs_ppc64le_cuda7_caffe_v1.7.1
#name=ubuntu_14_lts_docker_aufs_ppc64le_cuda7_v1.4.1
#name=ubuntu_14_lts_docker_aufs_ppc64le_opencv_v1.0.1
#name=ubuntu_14_lts_docker_aufs_ppc64le_xfce_v0.0.3
#name=ubuntu_14_lts_docker_aufs_ppc64le_capiinformix_v0.0.2

name=ubuntu_14_lts_docker_aufs_ppc64le_fftapp_v0.0.1

function dockerbuild(){
	docker build -t  ${name} ./
}


function glanceimage(){
docker save ${name} | glance image-create \
	       --is-public=False \
	       --container-format=docker \
	       --disk-format=raw \
	       --name ${name} \
	       --property hypervisor_type=docker \
	       --property image_type=image \
	       --property webshell=True \
	       --property sys_type=ubuntu \
	       --property os_type="Ubuntu-14-LTS-ppc64le" \
	       --property architecture=ppc64le \
	       --property accelerator_type=none \

}

function glanceupdate(){
glance image-update \
	       --is-public=True \
	       --property hypervisor_type=docker \
	       --property image_type=image \
	       --property webshell=True \
	       --property sys_type=ubuntu \
	       --property os_type="Ubuntu-14-LTS-ppc64le" \
	       --property architecture=ppc64le \
	       --property accelerator_type=fpga_capi \
	       ${name}

}

##main##
#dockerbuild
glanceimage
glanceupdate

