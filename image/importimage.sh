#!/bin/bash

set -x
srcdir=/gpfs/linzhbj

imagename=Ubuntu14.04.2-x86_64-KVM-100G-v1
glance image-create --name=${imagename} \
                           --is-public=True \
                           --property architecture=x86_64  \
                           --property accelerator_type=none \
                           --property hw_disk_bus=virtio \
                           --property hw_video_model=vga  \
                           --property hypervisor_type=kvm  \
                           --property os_type="Ubuntu14.04.2-x86_64" \
                           --container-format=bare \
                           --property image_type=custom_image \
                           --property sys_type=ubuntu \
                           --property webshell=true \
                           --disk-format=qcow2 \
                           --file  ${srcdir}/${imagename}.qcow2

#imagename=RHEL-7.1-x86_64-KVM-100G-v1.0.1
#glance image-create --name=${imagename} \
#                           --is-public=false \
#                           --property architecture=x86_64  \
#                           --property accelerator_type=none \
#                           --property hw_disk_bus=virtio \
#                           --property hw_video_model=vga  \
#                           --property hypervisor_type=kvm  \
#                           --property os_type="RHEL-7.1-x86_64" \
#                           --container-format=bare \
#                           --property image_type=image \
#                           --property sys_type=rhel \
#                           --property webshell=true \
#                           --disk-format=qcow2 \
#                           --file   ${srcdir}/${imagename}.qcow2

#imagename=RHEL-6.6-x86_64-KVM-200G-v1.0.1
#glance image-create --name=${imagename} \
#                           --is-public=false \
#                           --property architecture=x86_64  \
#                           --property accelerator_type=none \
#                           --property hw_disk_bus=virtio \
#                           --property hw_video_model=vga  \
#                           --property hypervisor_type=kvm  \
#                           --property os_type="RHEL-6.6-x86_64" \
#                           --container-format=bare \
#                           --property image_type=image \
#                           --property sys_type=rhel \
#                           --property webshell=true \
#                           --disk-format=qcow2 \
#                           --file   ${srcdir}/${imagename}.qcow2
#

#imagename=CentOS-7.2-ppc64le-KVM-v1.0.2
#glance image-create --name=${imagename} \
#                           --is-public=True \
#                           --property architecture=ppc64le \
#                           --property accelerator_type=none \
#                           --property hw_disk_bus=virtio \
#                           --property hw_video_model=vga  \
#                           --property hypervisor_type=kvm  \
#                           --property os_type="CentOS-7.2-ppc64le" \
#                           --container-format=bare \
#                           --property image_type=image \
#                           --property sys_type=centos \
#                           --property webshell=true \
#                           --disk-format=qcow2 \
#                           --file  ${srcdir}/${imagename}.qcow2

#imagename=CentOS-7.2-ppc64le-20G-KVM-ServerGUI-v1.0.1
#glance image-create --name=${imagename} \
#                           --is-public=True \
#                           --property architecture=ppc64le \
#                           --property accelerator_type=none \
#                           --property hw_disk_bus=virtio \
#                           --property hw_video_model=vga  \
#                           --property hypervisor_type=kvm  \
#                           --property os_type="CentOS-7.2-ppc64le" \
#                           --container-format=bare \
#                           --property image_type=image \
#                           --property sys_type=centos \
#                           --property webshell=true \
#                           --disk-format=qcow2 \
#                           --file  ${srcdir}/${imagename}.qcow2

#imagename=Ubuntu14.04.3-ppc64le-KVM-lvm20G-v1.0.1
#glance image-create --name=${imagename} \
#                           --is-public=True \
#                           --property architecture=ppc64le \
#                           --property accelerator_type=none \
#                           --property hw_disk_bus=virtio \
#                           --property hw_video_model=vga  \
#                           --property hypervisor_type=kvm  \
#                           --property os_type="Ubuntu14.04.3-ppc64le-KVM" \
#                           --container-format=bare \
#                           --property image_type=image \
#                           --property sys_type=ubuntu \
#                           --property webshell=true \
#                           --disk-format=qcow2 \
#                           --file  ${srcdir}/${imagename}.qcow2
#
#imagename=Ubuntu14.04.3-ppc64le-KVM-lvm100G-v1.0.1
#glance image-create --name=${imagename} \
#                           --is-public=True \
#                           --property architecture=ppc64le \
#                           --property accelerator_type=none \
#                           --property hw_disk_bus=virtio \
#                           --property hw_video_model=vga  \
#                           --property hypervisor_type=kvm  \
#                           --property os_type="Ubuntu14.04.3-ppc64le-KVM" \
#                           --container-format=bare \
#                           --property image_type=custom_image \
#                           --property sys_type=ubuntu \
#                           --property webshell=true \
#                           --disk-format=qcow2 \
#                           --file  ${srcdir}/${imagename}.qcow2
#
#
#imagename=Ubuntu14.04.4-ppc64le-KVM-lvm20G-v1.0.1
#glance image-create --name=${imagename} \
#                           --is-public=True \
#                           --property architecture=ppc64le \
#                           --property accelerator_type=none \
#                           --property hw_disk_bus=virtio \
#                           --property hw_video_model=vga  \
#                           --property hypervisor_type=kvm  \
#                           --property os_type="Ubuntu14.04.4-ppc64le-KVM" \
#                           --container-format=bare \
#                           --property image_type=image \
#                           --property sys_type=ubuntu \
#                           --property webshell=true \
#                           --disk-format=qcow2 \
#                           --file  ${srcdir}/${imagename}.qcow2
#
#imagename=Ubuntu14.04.4-ppc64le-KVM-lvm100G-v1.0.1
#glance image-create --name=${imagename} \
#                           --is-public=True \
#                           --property architecture=ppc64le \
#                           --property accelerator_type=none \
#                           --property hw_disk_bus=virtio \
#                           --property hw_video_model=vga  \
#                           --property hypervisor_type=kvm  \
#                           --property os_type="Ubuntu14.04.4-ppc64le-KVM" \
#                           --container-format=bare \
#                           --property image_type=custom_image \
#                           --property sys_type=ubuntu \
#                           --property webshell=true \
#                           --disk-format=qcow2 \
#                           --file  ${srcdir}/${imagename}.qcow2

#imagename=CentOS-7.2-x86_64-100G-KVM-v1.0.0
#glance image-create --name=${imagename} \
#                           --is-public=True \
#                           --property architecture=x86_64 \
#                           --property accelerator_type=none \
#                           --property hw_disk_bus=virtio \
#                           --property hw_video_model=vga  \
#                           --property hypervisor_type=kvm  \
#                           --property os_type="CentOS-7.2-x86_64-100G" \
#                           --container-format=bare \
#                           --property image_type=custom_image \
#                           --property sys_type=centos \
#                           --property webshell=true \
#                           --disk-format=qcow2 \
#                           --file  ${srcdir}/${imagename}.qcow2


#srcdir=/gpfs/linzhbj
#imagename=CentOS-7.2-ppc64le-100G-KVM-v1.0.1
#glance image-create --name=${imagename} \
#                           --is-public=True \
#                           --property architecture=ppc64le  \
#                           --property accelerator_type=none \
#                           --property hw_disk_bus=virtio \
#                           --property hw_video_model=vga  \
#                           --property hypervisor_type=kvm  \
#                           --property os_type="CentOS-7.2-ppc64le" \
#                           --container-format=bare \
#                           --property image_type=custom_image \
#                           --property sys_type=centos \
#                           --property webshell=true \
#                           --disk-format=qcow2 \
#                           --file  ${srcdir}/${imagename}.qcow2


#imagename=CentOS-7.2-x86_64-KVM-v1.0.1
#glance image-create --name=${imagename} \
#                           --is-public=True \
#                           --property architecture=x86_64  \
#                           --property accelerator_type=none \
#                           --property hw_disk_bus=virtio \
#                           --property hw_video_model=vga  \
#                           --property hypervisor_type=kvm  \
#                           --property os_type="CentOS-7.2-x86_64" \
#                           --container-format=bare \
#                           --property image_type=image \
#                           --property sys_type=centos \
#                           --property webshell=true \
#                           --disk-format=qcow2 \
#                           --file  ${srcdir}/${imagename}.qcow2
#



#imagename=CentOS-7.2-ppc64le-KVM-v1.0.1
#glance image-create --name=${imagename} \
#                           --is-public=True \
#                           --property architecture=ppc64le  \
#                           --property accelerator_type=none \
#                           --property hw_disk_bus=virtio \
#                           --property hw_video_model=vga  \
#                           --property hypervisor_type=kvm  \
#                           --property os_type="CentOS-7.2-ppc64le" \
#                           --container-format=bare \
#                           --property image_type=image \
#                           --property sys_type=centos \
#                           --property webshell=true \
#                           --disk-format=qcow2 \
#                           --file  ${srcdir}/${imagename}.qcow2
#

#                           glance image-update --property sys_type=centos --is-public=true edc064a0-b982-434b-a280-8286a173c8f0



#srcdir=/os-image1/OpenPowerDataBak
#imagename=RHEL-7.1-ppc64le-KVM-100G-v1.0.2
#glance image-create --name=${imagename} \
#                           --is-public=false \
#                           --property architecture=ppc64le  \
#                           --property accelerator_type=none \
#                           --property hw_disk_bus=virtio \
#                           --property hw_video_model=vga  \
#                           --property hypervisor_type=kvm  \
#                           --property os_type="RHEL-7.1-ppc64le" \
#                           --container-format=bare \
#                           --property image_type=image \
#                           --property sys_type=rhel \
#                           --property webshell=true \
#                           --disk-format=qcow2 \
#                           --file  ${srcdir}/${imagename}.qcow2

#glance image-create --name=Ubuntu12.04.5-x86_64-KVM-v0.0.1 \
#                           --property accelerator_type=none \
#                           --is-public=true \
#                           --property architecture=x86_64  \
#                           --property hw_disk_bus=virtio \
#                           --property hw_video_model=vga  \
#                           --property hypervisor_type=kvm  \
#                           --property os_type="Ubuntu12.04.5-x86_64" \
#                           --container-format=bare \
#                           --property image_type=image \
#                           --property sys_type=ubuntu \
#                           --property webshell=true \
#                           --disk-format=qcow2 \
#                           --file  /os-image1/OpenPowerDataBak/Ubuntu12.04.5-x86_64-KVM-v0.0.1.qcow2


#glance image-create --name=Ubuntu14.04.1-ppc64le-KVM-v0.0.1-Bate1 \
#                           --is-public=false \
#                           --property architecture=ppc64le  \
#                           --property hw_disk_bus=virtio \
#                           --property hw_video_model=vga  \
#                           --property hypervisor_type=kvm  \
#                           --property os_type="Ubuntu14.04.1-ppc64le" \
#                           --container-format=bare \
#                           --property image_type=image \
#                           --property sys_type=ubuntu \
#                           --property webshell=true \
#                           --disk-format=qcow2 \
#                           --file  /os-image1/OpenPowerDataBak/ubuntu-14.04.1-ppc64le-v0.0.1.qcow2
#

#glance image-create --name=isoft-3.0-ppc64-virtio-v0.0.1 \
#                           --is-public=false \
#                           --property accelerator_type=none \
#                           --property architecture=ppc64  \
#                           --property hw_disk_bus=virtio \
#                           --property hw_video_model=vga  \
#                           --property hypervisor_type=kvm  \
#                           --property os_type="Isoft-3.0-ppc64" \
#                           --container-format=bare \
#                           --property image_type=image \
#                           --property sys_type=rhel \
#                           --property webshell=true \
#                           --disk-format=qcow2 \
#                           --file  /os-image1/OpenPowerDataBak/isoft-3.0-ppc64-virtio-v0.0.1.qcow2





#glance image-create --name=Asianux-7rc2-ppc64le-KVM-v0.0.1 \
#                           --is-public=True \
#                           --property architecture=ppc64le  \
#                           --property hw_disk_bus=scsi \
#                           --property hw_video_model=vga  \
#                           --property hypervisor_type=kvm  \
#                           --property os_type="Asianux-ppc64le" \
#                           --container-format=bare \
#                           --property image_type=image \
#                           --property sys_type=rhel \
#                           --disk-format=qcow2 < /os-image1/OpenPowerDataBak/Asianux-7rc2-ppc64le-KVM-v0.0.1.qcow2
#

#glance image-create --name=Asianux-4-sp4-ppc64be-KVM-v0.0.1 \
#                           --is-public=True \
#                           --property architecture=ppc64  \
#                           --property hw_disk_bus=scsi \
#                           --property hw_video_model=vga  \
#                           --property hypervisor_type=kvm  \
#                           --property os_type="Asianux-ppc64be" \
#                           --container-format=bare \
#                           --property image_type=image \
#                           --property sys_type=rhel \
#                           --disk-format=qcow2 < /os-image1/OpenPowerDataBak/Asianux-4-sp4-ppc64be-KVM-v0.0.1.qcow2



#glance image-create --name=RHEL-7.1-ppc64le-KVM-v0.0.1 \
#                           --is-public=false \
#                           --property architecture=ppc64le  \
#                           --property hw_disk_bus=virtio \
#                           --property hw_video_model=vga  \
#                           --property hypervisor_type=kvm  \
#                           --property os_type="RHEL-7.1-ppc64le" \
#                           --container-format=bare \
#                           --property image_type=image \
#                           --property sys_type=rhel \
#                           --property webshell=false \
#                           --disk-format=qcow2 \
#                           --file  /os-image1/OpenPowerDataBak/rhel7.1-ppc64le-virtio-v0.0.1.qcow2

#glance image-create --name=RHEL-7.1-ppc64-KVM-v0.0.1 \
#                           --is-public=false \
#                           --property architecture=ppc64  \
#                           --property hw_disk_bus=virtio \
#                           --property hw_video_model=vga  \
#                           --property hypervisor_type=kvm  \
#                           --property os_type="RHEL-7.1-ppc64" \
#                           --container-format=bare \
#                           --property image_type=image \
#                           --property sys_type=rhel \
#                           --property webshell=true \
#                           --disk-format=qcow2 \
#                           --file  /os-image1/OpenPowerDataBak/rhel7.1-ppc64-virtio.qcow2
#

#glance image-create --name=Ubuntu14.04.3-ppc64le-KVM-v0.0.1 \
#                           --is-public=false \
#                           --property architecture=ppc64le  \
#                           --property hw_disk_bus=virtio \
#                           --property hw_video_model=vga  \
#                           --property hypervisor_type=kvm  \
#                           --property os_type="Ubuntu14.04.3-ppc64le" \
#                           --container-format=bare \
#                           --property image_type=image \
#                           --property sys_type=ubuntu \
#                           --property webshell=true \
#                           --disk-format=qcow2 \
#                           --file  /os-image1/OpenPowerDataBak/ubuntu14.04.3-ppc64le-virtio-0.0.1.qcow2
#

