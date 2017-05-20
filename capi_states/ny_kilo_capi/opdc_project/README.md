


opdc2017
usermod -p '$6$npdeMYdH$fDVSTvQqx49TUgqcHtKd/GUwzG7IFNdwwjHfgSg4WQ.9Yqxd68IVEn9MQoPddMVhFceg449W8zikBtd150ATO.' root
usermod -p '$6$npdeMYdH$fDVSTvQqx49TUgqcHtKd/GUwzG7IFNdwwjHfgSg4WQ.9Yqxd68IVEn9MQoPddMVhFceg449W8zikBtd150ATO.' opuser

chage -d 17305 root
chage -m 0     root
chage -M 99999 root

chage -d 17305 opuser
chage -m 0     opuser
chage -M 99999 opuser

rm -rf /home/opuser/.bash_history
rm -rf /home/opuser/.viminfo
history -c
history -w










glance  image-update dfd3b5c9-9843-4fdd-ad28-0ba9a1adb897 --is-public=true --property image_type=custome_image
+-----------------------------+--------------------------------------+
| Property                    | Value                                |
+-----------------------------+--------------------------------------+
| Property 'accelerator_type' | none                                 |
| Property 'architecture'     | ppc64le                              |
| Property 'base_image_ref'   | b068e7b8-4e72-4267-b62e-07171e571af8 |
| Property 'hypervisor_type'  | docker                               |
| Property 'image_location'   | snapshot                             |
| Property 'image_state'      | available                            |
| Property 'image_type'       | custome_image                        |
| Property 'instance_uuid'    | f7431aeb-6f59-47eb-a30d-de5de60e8c74 |
| Property 'os_type'          | Linux                                |
| Property 'owner_id'         | 4e29c5e6ebe74eb683fc5e34a6e7e89d     |
| Property 'ramdisk_id'       | None                                 |
| Property 'status'           | available                            |
| Property 'sys_type'         | ubuntu                               |
| Property 'user_id'          | 230eec8ccce1426b9cfd63c0887fcaee     |
| Property 'webshell'         | True                                 |
| checksum                    | 1f01d35b1589a613b85050744c5ef771     |
| container_format            | docker                               |
| created_at                  | 2017-05-19T12:18:49.000000           |
| deleted                     | False                                |
| deleted_at                  | None                                 |
| disk_format                 | raw                                  |
| id                          | dfd3b5c9-9843-4fdd-ad28-0ba9a1adb897 |
| is_public                   | True                                 |
| min_disk                    | 20                                   |
| min_ram                     | 0                                    |
| name                        | ubuntu1604_ppc64le_opdc_v1           |
| owner                       | b82bfb9f005d4f4dab50dd36fe8760fc     |
| protected                   | False                                |
| size                        | 2490458624                           |
| status                      | active                               |
| updated_at                  | 2017-05-19T12:32:13.000000           |
| virtual_size                | None                                 |
+-----------------------------+--------------------------------------+

