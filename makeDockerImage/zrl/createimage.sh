#!/bin/bash
set -x
#name=ubuntu_14_lts_docker_aufs_ppc64le_cuda7_caffe_v1.7.1
#name=ubuntu_14_lts_docker_aufs_ppc64le_cuda7_v1.4.1
#name=ubuntu_14_lts_docker_aufs_ppc64le_opencv_v1.0.1
#name=ubuntu_14_lts_docker_aufs_ppc64le_xfce_v0.0.3
#name=ubuntu_14_lts_docker_aufs_ppc64le_capiinformix_v0.0.2
#name=ubuntu_14_lts_docker_aufs_ppc64le_fftapp_v0.0.1

name=ubuntu_ppc64le_1604_v0.5

function dockerbuild(){
	docker build -t  ${name} ./
}


function saveimage(){
docker save -o ${name} ${name}
}

function glanceimage(){
glance image-create \
	       --visibility public \
	       --container-format=docker \
	       --disk-format=raw \
	       --name ${name} \
	       --file ./${name} \
	       --property hypervisor_type=docker \
	       --property image_type=image \
	       --property webshell=True \
	       --property sys_type=ubuntu \
	       --property os_type="Ubuntu-16-LTS-ppc64le" \
	       --property architecture=ppc64le \
	       --property accelerator_type=capi_fpga \

}

function glanceupload(){
docker save ${name} | glance image-create \
               --visibility public \
               --container-format=docker \
               --disk-format=raw \
               --name ${name} \
               --property hypervisor_type=docker \
               --property image_type=image \
               --property webshell=True \
               --property sys_type=ubuntu \
               --property os_type="Ubuntu-16-LTS-ppc64le" \
               --property architecture=ppc64le \
               --property accelerator_type=capi_fpga \

}


function glanceupdate(){
imgid=`glance image-list | grep ${name} | awk '{print $2}'`
glance image-update \
	       --visibility public \
	       --property hypervisor_type=docker \
	       --property image_type=image \
	       --property webshell=True \
	       --property sys_type=ubuntu \
	       --property os_type="Linux" \
	       --property architecture=ppc64le \
	       --property accelerator_type=fpga_capi \
	       --property base_type=base \
	       --property diskSize=100 \
	       --property hw_disk_bus=virtio \
	       --property hw_video_model=vga \
	       --property imageUuid=ubuntu_1604 \
	       ${imgid}

}


##main##
dockerbuild
saveimage
##glanceupload
glanceimage
glanceupdate

