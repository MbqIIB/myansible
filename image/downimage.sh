#!/bin/bash

set -x
#imagelist=( \
#centos_7.2_docker_aufs_x86_64_v1.0.3        \
#rhel_7.1_docker_aufs_x86_64_v0.0.4          \
#ubuntu_14.04.2_docker_aufs_x86_64_v0.0.4    \
#        )

#imagelist=( \
#centos_7.2_docker_aufs_ppc64le_v1.0.2                \
#centos_7.2_docker_aufs_ppc64le_xlc13.1.3.1_v1.0.1     \
#centos_7.2_docker_aufs_x86_64_v1.0.3                  \
#)

imagelist=( \
Ubuntu14.04.3-ppc64le-KVM-Docker1.9.1-v1 \
)

for name in ${imagelist[@]}
do
    echo ${name}
    #suf=$(glance image-list | grep ${name} |awk -F ' ' '{print $6}')
    suf=$(glance image-show ${name} | grep disk_format | awk -F ' ' '{print $4}')
    echo ${name}.${suf}

    echo "start download ${name}"
    glance image-download \
        --file ${name}.${suf} ${name}
    
    chown opadmin:opadmin ${name}.${suf}

    echo "sleep 60 s"
    sleep 60
done

echo "Finish"

