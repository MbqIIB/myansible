#!/bin/bash

set -x
nova boot --flavor docker.small \
        --image ubuntu_14_lts_docker_aufs_ppc64le_v0.1.0 \
        --nic net-id=0fba9e89-f3c1-418e-9b86-a96ca3fc2274 \
	--availability-zone nova:ent-cp5-ppc64le  \
        --meta accelerator_type=fpga_capi \
        --meta accelerator_count=1 \
        --meta accelerator_image1="{\"fpga_board\": \"Semptian_120B\", \"bw\": \"1000\", \"name\": \"AccDNN-F4B4\", \"id\": \"32b274d1-a28d-4fc6-89f0-3b127e07f4a8\"}" \
        linzhbj-testcapi

