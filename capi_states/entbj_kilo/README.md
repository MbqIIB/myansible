# deploy capi in ent


# check diff  ent-cp5  and ny1 svp9
``` shell
chmod a+rx /usr/local/lib/python2.7/dist-packages/


find svp9_novadocker/ -name "*.pyo"  -delete

cp -r /usr/lib/python2.7/dist-packages/nova entcp5_nova
cp -r /usr/lib/python2.7/dist-packages/novaclient entcp5_novaclient

vim novadocker5_9.patch
find entcp5_novadocker/ -name "*.pyo"  -delete
find entcp5_novadocker/ -name "*.pyc"  -delete
diff -ur entcp5_novadocker/ svp9_novadocker/ > novadocker5_9.patch 
vim novadocker5_9.patch



dir=entcp5_novaclient
dir=/usr/lib/python2.7/dist-packages/nova
find ${dir} -name "*.pyc"  -delete
find ${dir} -name "*.pyo"  -delete



diff -ur entcp5_novaclient/ svp9_novaclient/ > novaclient5_9.patch 


dir=/usr/lib/python2.7/dist-packages/nova
grep -rn "Alphadata-KU3" ${dir}

scp -r cp6:/gpfs/gpfs_enterprise/ent-cp5bak20170518/capi/AccDNN-F4B4.ops



nova boot --flavor docker.small --image ubuntu_14_lts_docker_aufs_ppc64le_v0.1.0 --nic net-id=0dc977d0-90ce-4055-aac4-cb4ee21bc461 --meta accelerator_type=fpga_capi --meta accelerator_count=1 --meta accelerator_image1="{\"fpga_board\": \"FlashGT\", \"bw\": \"1000\", \"name\": \"fft1d-ku3-v1\", \"id\": \"d0bd35b0-031d-475e-8f72-c20ed0210ab7\"}" chenfeiFlash


diff -ur entcp5_nova/api/openstack/compute/servers.py svp9_nova/api/openstack/compute/servers.py
diff -ur entcp5_nova/compute/api.py svp9_nova/compute/api.py
diff -ur entcp5_nova/compute/gpu_states.py svp9_nova/compute/gpu_states.py
diff -ur entcp5_nova/compute/manager.py svp9_nova/compute/manager.py
diff -ur entcp5_nova/compute/resource_tracker.py svp9_nova/compute/resource_tracker.py
diff -ur entcp5_nova/compute/rpcapi.py svp9_nova/compute/rpcapi.py
diff -ur entcp5_nova/objects/compute_node.py svp9_nova/objects/compute_node.py


ref: [git@github.ibm.com:bjzhuc/acc_IaaS.git]
[git@github.ibm.com:supervessel/IaaS-nova-docker.git]

glance image-update --property acc_name=AccDNN-F4B4 --property acc_type=capi --property accelerator_type=none --property chip_sn=xcku115 --property chip_vendor=Xilinx --property fpga_board=Semptian_120B --property image_type=accelerator 32b274d1-a28d-4fc6-89f0-3b127e07f4a8
+-----------------------------+--------------------------------------+
| Property                    | Value                                |
+-----------------------------+--------------------------------------+
| Property 'acc_name'         | AccDNN-F4B4                          |
| Property 'acc_type'         | capi                                 |
| Property 'accelerator_type' | none                                 |
| Property 'chip_sn'          | xcku115                              |
| Property 'chip_vendor'      | Xilinx                               |
| Property 'fpga_board'       | Semptian_120B                        |
| Property 'image_type'       | accelerator                          |
| checksum                    | e99582329775f9a50b3425bf8a5191f6     |
| container_format            | bare                                 |
| created_at                  | 2017-05-19T10:37:40.000000           |
| deleted                     | False                                |
| deleted_at                  | None                                 |
| disk_format                 | ops                                  |
| id                          | 32b274d1-a28d-4fc6-89f0-3b127e07f4a8 |
| is_public                   | True                                 |
| min_disk                    | 0                                    |
| min_ram                     | 0                                    |
| name                        | AccDNN-F4B4                          |
| owner                       | 3f9aeb258def4e468bf11f1a03870199     |
| protected                   | False                                |
| size                        | 23651600                             |
| status                      | active                               |
| updated_at                  | 2017-05-19T10:37:45.000000           |
| virtual_size                | None                                 |
+-----------------------------+--------------------------------------+




nova boot --flavor docker.small \
	--image ubuntu_14_lts_docker_aufs_ppc64le_v0.1.0 \
	--nic net-id=0fba9e89-f3c1-418e-9b86-a96ca3fc2274 \
	--meta accelerator_type=fpga_capi \
	--meta accelerator_count=1 \
	--availability-zone nova:ent-cp5-ppc64le  \
	--meta accelerator_image1="{\"fpga_board\": \"Semptian_120B\", \"bw\": \"1000\", \"name\": \"AccDNN-F4B4\", \"id\": \"32b274d1-a28d-4fc6-89f0-3b127e07f4a8\"}" \
	linzhbj-testcapi 


```
