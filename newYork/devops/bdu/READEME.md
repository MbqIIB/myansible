
[bdu@ansible ~]$ ssh-keygen -C bdu@ibm.com
Generating public/private rsa key pair.
Enter file in which to save the key (/home/bdu/.ssh/id_rsa):
Created directory '/home/bdu/.ssh'.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/bdu/.ssh/id_rsa.
Your public key has been saved in /home/bdu/.ssh/id_rsa.pub.
The key fingerprint is:
1e:f4:8c:97:25:8e:58:45:3e:b0:53:28:f4:dc:73:0f bdu@ibm.com
The key's randomart image is:
+--[ RSA 2048]----+
|     .. .o+      |
|      .o.B       |
|       .B * E    |
|       + B B o   |
|      . S *   .  |
|       . o       |
|        .        |
|                 |
|                 |
+-----------------+

 nova keypair-add --pub-key ctlkey/id_rsa.pub CtlKey


[bdu@ansible ~]$ cp ~/.ssh/ bdukey -r
[bdu@ansible ~]$  nova keypair-add --pub-key bdukey/id_rsa.pub bduKey
[bdu@ansible ~]$ nova keypair-list
+--------+-------------------------------------------------+
| Name   | Fingerprint                                     |
+--------+-------------------------------------------------+
| bduKey | 1e:f4:8c:97:25:8e:58:45:3e:b0:53:28:f4:dc:73:0f |
+--------+-------------------------------------------------+



+ grep bdu.smt20.5c4t64g100gd flavorlist.log
| 7d64d3a1-3f46-458a-856d-a7c85cb2174f | bdu.smt20.5c4t64g100gd   | 65536     | 100  | 0         |      | 20    | 1.0         | True      | {u'hw:cpu_cores': u'1', u'hw:cpu_threads': u'4', u'hw:cpu_sockets': u'5', u'aggregate_instance_extra_specs:filter_tenant_id': u'68993eec2c5e4931903bc949af53bff4'} |
+ '[' 0 '!=' 0 ']'
+ grep bdu.smt20.5c4t64g100gd flavorlist.log
| 7d64d3a1-3f46-458a-856d-a7c85cb2174f | bdu.smt20.5c4t64g100gd   | 65536     | 100  | 0         |      | 20    | 1.0         | True      | {u'hw:cpu_cores': u'1', u'hw:cpu_threads': u'4', u'hw:cpu_sockets': u'5', u'aggregate_instance_extra_specs:filter_tenant_id': u'68993eec2c5e4931903bc949af53bff4'} |
+ '[' 0 '!=' 0 ']'
++ grep ' bdu.smt20.5c4t64g100gd ' flavorlist.log
++ awk -F '|' '{print $2}'
+ fid=' 7d64d3a1-3f46-458a-856d-a7c85cb2174f '
+ (( i=0 ))
+ (( i<1 ))
++ echo fnode2-7
++ sed s/ent-//g
++ sed s/.ibm.com//g
+ nodename=fnode2-7
++ echo bdu.smt20.5c4t64g100gd
++ sed 's/\.//g'
+ insname=testgpu-fnode2-7-bdusmt205c4t64g100gd-20170518_114231n0
+ '[' XbduKey '!=' X ']'
++ nova boot --flavor 7d64d3a1-3f46-458a-856d-a7c85cb2174f --key-name=bduKey --image ubuntu-16.04.2-server-cloudimg-ppc64el-anydisk1-v2 --availability-zone BDU-az:fnode2-7 --meta accelerator_type=gpu_pcie --meta gpu_num=1 --nic net-id=06bdbd3e-e21e-42bd-a003-944e889bdfb3 testgpu-fnode2-7-bdusmt205c4t64g100gd-20170518_114231n0
++ grep ' id '
++ awk -F ' ' '{print $4}'
ERROR (Forbidden): Quota exceeded for ram: Requested 65536, but already used 0 of 51200 ram (HTTP 403) (Request-ID: req-c6eb76cc-e876-4839-b07e-bf43aecfe61a)

+ nova quota-update --instances 30 --core 500 --floating-ips 100 --ram 204800 68993eec2c5e4931903bc949af53bff4
+ nova quota-update --instances 30 --core 500 --ram 204800 --floating-ips 100 --user 312ce975b2174f65864608716f297d86 68993eec2c5e4931903bc949af53bff4
nova quota-show 

[bdu@ansible ~]$ nova quota-show
+-----------------------------+--------+
| Quota                       | Limit  |
+-----------------------------+--------+
| instances                   | 30     |
| cores                       | 500    |
| ram                         | 204800 |
| floating_ips                | 100    |
| fixed_ips                   | -1     |
| metadata_items              | 128    |
| injected_files              | 5      |
| injected_file_content_bytes | 10240  |
| injected_file_path_bytes    | 255    |
| key_pairs                   | 100    |
| security_groups             | 10     |
| security_group_rules        | 20     |
| server_groups               | 10     |
| server_group_members        | 10     |
+-----------------------------+--------+



++ nova boot --flavor 7d64d3a1-3f46-458a-856d-a7c85cb2174f --key-name=bduKey --image ubuntu-16.04.2-server-cloudimg-ppc64el-anydisk1-v2 --availability-zone BDU-az:fnode2-7 --meta accelerator_type=gpu_pcie --meta gpu_num=1 --nic net-id=06bdbd3e-e21e-42bd-a003-944e889bdfb3 testgpu-fnode2-7-bdusmt205c4t64g100gd-20170518_114841n0
+ InstanceId=b574bd74-ee43-4b24-a564-1c12fa417618
+ '[' 0 '!=' 0 ']'
+ sleep 5
++ nova floating-ip-create 21f68f9c-db79-4c58-ad5e-7072f615cc97
++ grep pub-net1
++ awk -F ' ' '{print $4}'
+ fip2=172.31.216.64
+ sleep 2
+ nova floating-ip-associate b574bd74-ee43-4b24-a564-1c12fa417618 172.31.216.64



  511  2017-03-09 01:28:01 :: cd /usr/lib/python2.7/dist-packages/
  512  2017-03-09 01:28:07 :: cd nova
  513  2017-03-09 01:28:11 :: clear
  514  2017-03-09 01:29:15 :: cp ~/nova-kvm-gpu/compute-node/nova/gpus_kvm.py .
  515  2017-03-09 01:30:14 :: cd compute/
  516  2017-03-09 01:30:25 :: vim resource_tracker.py
  517  2017-03-09 01:33:12 :: cp resource_tracker.py resource_tracker.py.bak0309
  518  2017-03-09 01:33:35 :: cp ~/nova-kvm-gpu/compute-node/nova/compute/resource_tracker.py .
  519  2017-03-09 01:34:08 :: cd ../objects/
  520  2017-03-09 01:34:25 :: cp compute_node.py compute_node.py.bak0309
  521  2017-03-09 01:34:50 :: cp ~/nova-kvm-gpu/compute-node/nova/objects/compute_node.py .
  522  2017-03-09 01:35:39 :: cd ../virt/libvirt/
  523  2017-03-09 01:35:58 :: cp config.py config.py.bak0309
  524  2017-03-09 01:36:18 :: cp driver.py driver.py.bak0309
  525  2017-03-09 01:36:43 :: cp ~/nova-kvm-gpu/compute-node/nova/virt/libvirt/* .

 compute_node name:fnode2-7, avaliable GPU count:3


+ nova floating-ip-associate 9a4d9dbe-058d-4248-9737-a177fc5fa516 172.31.216.66






[(DevOps)root@ansible devops]# neutron floatingip-create  --floating-ip-address 172.31.250.240 --tenant-id 68993eec2c5e4931903bc949af53bff4 21f68f9c-db79-4c58-ad5e-7072f615cc97
Created a new floatingip:
+---------------------+--------------------------------------+
| Field               | Value                                |
+---------------------+--------------------------------------+
| description         |                                      |
| fixed_ip_address    |                                      |
| floating_ip_address | 172.31.250.240                       |
| floating_network_id | 21f68f9c-db79-4c58-ad5e-7072f615cc97 |
| id                  | 41747884-0cd2-44be-8233-1b10ade6ad98 |
| port_id             |                                      |
| router_id           |                                      |
| status              | DOWN                                 |
| tenant_id           | 68993eec2c5e4931903bc949af53bff4     |
+---------------------+--------------------------------------+


[bdu@ansible ~]$ neutron floatingip-list
+--------------------------------------+------------------+---------------------+--------------------------------------+
| id                                   | fixed_ip_address | floating_ip_address | port_id                              |
+--------------------------------------+------------------+---------------------+--------------------------------------+
| 41747884-0cd2-44be-8233-1b10ade6ad98 |                  | 172.31.250.240      |                                      |
| 6b98ce9b-88b4-4418-9a8c-68eef3a9c4c1 | 10.11.1.208      | 172.31.216.66       | 8fe637a2-9f76-49b2-a622-6ed0e10ca85e |
+--------------------------------------+------------------+---------------------+--------------------------------------+


[bdu@ansible ~]$ nova list
n+--------------------------------------+-----------------------------------------------------+--------+------------+-------------+--------------------------------------------+
| ID                                   | Name                                                | Status | Task State | Power State | Networks                                   |
+--------------------------------------+-----------------------------------------------------+--------+------------+-------------+--------------------------------------------+
| 9a4d9dbe-058d-4248-9737-a177fc5fa516 | BDU-fnode2-7-bdusmt205c4t64g100gd-20170518_122045n0 | ACTIVE | -          | Running     | priv-net-vxlan1=10.11.1.208, 172.31.216.66 |
+--------------------------------------+-----------------------------------------------------+--------+------------+-------------+--------------------------------------------+
[bdu@ansible ~]$ nova stop 9a4d9dbe-058d-4248-9737-a177fc5fa516
Request to stop server 9a4d9dbe-058d-4248-9737-a177fc5fa516 has been accepted.
[bdu@ansible ~]$


 nova floating-ip-disassociate 9a4d9dbe-058d-4248-9737-a177fc5fa516 172.31.216.66

 nova floating-ip-associate 9a4d9dbe-058d-4248-9737-a177fc5fa516 172.31.250.240



[bdu@ansible ~]$ nova list
+--------------------------------------+-----------------------------------------------------+---------+------------+-------------+---------------------------------------------+
| ID                                   | Name                                                | Status  | Task State | Power State | Networks                                    |
+--------------------------------------+-----------------------------------------------------+---------+------------+-------------+---------------------------------------------+
| 9a4d9dbe-058d-4248-9737-a177fc5fa516 | BDU-fnode2-7-bdusmt205c4t64g100gd-20170518_122045n0 | SHUTOFF | -          | Shutdown    | priv-net-vxlan1=10.11.1.208, 172.31.250.240 |
+--------------------------------------+-----------------------------------------------------+---------+------------+-------------+---------------------------------------------+



opuser@bdu-fnode2-7-bdusmt205c4t64g100gd-20170518-122045n0:~$ lspci
00:01.0 Ethernet controller: Red Hat, Inc Virtio network device
00:02.0 USB controller: Apple Inc. KeyLargo/Intrepid USB
00:03.0 SCSI storage controller: Red Hat, Inc Virtio block device
00:04.0 Unclassified device [00ff]: Red Hat, Inc Virtio memory balloon
00:05.0 VGA compatible controller: Device 1234:1111 (rev 02)
00:06.0 3D controller: NVIDIA Corporation GK210GL [Tesla K80] (rev a1)
opuser@bdu-fnode2-7-bdusmt205c4t64g100gd-20170518-122045n0:~$ exit
logout
Connection to 172.31.250.240 closed.
[bdu@ansible ~]$ ssh opuser@172.31.250.240
Welcome to Ubuntu 16.04.2 LTS (GNU/Linux 4.4.0-78-generic ppc64le)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  Get cloud support with Ubuntu Advantage Cloud Guest:
    http://www.ubuntu.com/business/services/cloud

41 packages can be updated.
0 updates are security updates.


To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

opuser@bdu-fnode2-7-bdusmt205c4t64g100gd-20170518-122045n0:~$ lscpu
Architecture:          ppc64le
Byte Order:            Little Endian
CPU(s):                20
On-line CPU(s) list:   0-19
Thread(s) per core:    4
Core(s) per socket:    1
Socket(s):             5
NUMA node(s):          1
Model:                 2.0 (pvr 004d 0200)
Model name:            POWER8 (raw), altivec supported
Hypervisor vendor:     KVM
Virtualization type:   para
L1d cache:             64K
L1i cache:             32K
NUMA node0 CPU(s):     0-19
opuser@bdu-fnode2-7-bdusmt205c4t64g100gd-20170518-122045n0:~$ free -g
              total        used        free      shared  buff/cache   available
Mem:             63           0          63           0           0          63
Swap:             0           0           0
opuser@bdu-fnode2-7-bdusmt205c4t64g100gd-20170518-122045n0:~$ exit





opuser@bdu-fnode2-7-bdusmt205c4t64g100gd-20170518-122045n0:~$ df -h
Filesystem      Size  Used Avail Use% Mounted on
udev             32G     0   32G   0% /dev
tmpfs           6.4G   18M  6.4G   1% /run
/dev/vda1        97G  1.3G   96G   2% /
tmpfs            32G     0   32G   0% /dev/shm
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs            32G     0   32G   0% /sys/fs/cgroup
tmpfs           6.4G     0  6.4G   0% /run/user/1000



[bdu@ansible ~]$ nova show 9a4d9dbe-058d-4248-9737-a177fc5fa516
+--------------------------------------+-------------------------------------------------------------------------------------------+
| Property                             | Value                                                                                     |
+--------------------------------------+-------------------------------------------------------------------------------------------+
| OS-DCF:diskConfig                    | MANUAL                                                                                    |
| OS-EXT-AZ:availability_zone          | BDU-az                                                                                    |
| OS-EXT-STS:power_state               | 4                                                                                         |
| OS-EXT-STS:task_state                | -                                                                                         |
| OS-EXT-STS:vm_state                  | stopped                                                                                   |
| OS-SRV-USG:launched_at               | 2017-05-18T16:20:58.000000                                                                |
| OS-SRV-USG:terminated_at             | -                                                                                         |
| accessIPv4                           |                                                                                           |
| accessIPv6                           |                                                                                           |
| config_drive                         |                                                                                           |
| created                              | 2017-05-18T16:20:49Z                                                                      |
| flavor                               | bdu.smt20.5c4t64g100gd (7d64d3a1-3f46-458a-856d-a7c85cb2174f)                             |
| hostId                               | 8bca9e8c3c55e2e22cbd8465a0a6b5890c65a0abf61db150bf88f6dc                                  |
| id                                   | 9a4d9dbe-058d-4248-9737-a177fc5fa516                                                      |
| image                                | ubuntu-16.04.2-server-cloudimg-ppc64el-anydisk1-v2 (ff2fd587-c2e3-424c-97aa-096a69592426) |
| key_name                             | bduKey                                                                                    |
| metadata                             | {"accelerator_type": "gpu_pcie", "gpu_num": "1"}                                          |
| name                                 | BDU-fnode2-7-bdusmt205c4t64g100gd-20170518_122045n0                                       |
| os-extended-volumes:volumes_attached | []                                                                                        |
| priv-net-vxlan1 network              | 10.11.1.208, 172.31.250.240                                                               |
| security_groups                      | default                                                                                   |
| status                               | SHUTOFF                                                                                   |
| tenant_id                            | 68993eec2c5e4931903bc949af53bff4                                                          |
| updated                              | 2017-05-18T16:43:37Z                                                                      |
| user_id                              | 312ce975b2174f65864608716f297d86                                                          |
+--------------------------------------+-------------------------------------------------------------------------------------------+
[bdu@ansible ~]$ nova rebuild  9a4d9dbe-058d-4248-9737-a177fc5fa516 ff2fd587-c2e3-424c-97aa-096a69592426
+-------------------------+-------------------------------------------------------------------------------------------+
| Property                | Value                                                                                     |
+-------------------------+-------------------------------------------------------------------------------------------+
| OS-DCF:diskConfig       | MANUAL                                                                                    |
| accessIPv4              |                                                                                           |
| accessIPv6              |                                                                                           |
| adminPass               | QevWcig3rpzc                                                                              |
| created                 | 2017-05-18T16:20:49Z                                                                      |
| flavor                  | bdu.smt20.5c4t64g100gd (7d64d3a1-3f46-458a-856d-a7c85cb2174f)                             |
| hostId                  | 8bca9e8c3c55e2e22cbd8465a0a6b5890c65a0abf61db150bf88f6dc                                  |
| id                      | 9a4d9dbe-058d-4248-9737-a177fc5fa516                                                      |
| image                   | ubuntu-16.04.2-server-cloudimg-ppc64el-anydisk1-v2 (ff2fd587-c2e3-424c-97aa-096a69592426) |
| metadata                | {"accelerator_type": "gpu_pcie", "gpu_num": "1"}                                          |
| name                    | BDU-fnode2-7-bdusmt205c4t64g100gd-20170518_122045n0                                       |
| priv-net-vxlan1 network | 10.11.1.208, 172.31.250.240                                                               |
| progress                | 0                                                                                         |
| status                  | REBUILD                                                                                   |
| tenant_id               | 68993eec2c5e4931903bc949af53bff4                                                          |
| updated                 | 2017-05-18T16:44:04Z                                                                      |
| user_id                 | 312ce975b2174f65864608716f297d86                                                          |
+-------------------------+-------------------------------------------------------------------------------------------+
[bdu@ansible ~]$ nova list
+--------------------------------------+-----------------------------------------------------+---------+------------------+-------------+---------------------------------------------+
| ID                                   | Name                                                | Status  | Task State       | Power State | Networks                                    |
+--------------------------------------+-----------------------------------------------------+---------+------------------+-------------+---------------------------------------------+
| 9a4d9dbe-058d-4248-9737-a177fc5fa516 | BDU-fnode2-7-bdusmt205c4t64g100gd-20170518_122045n0 | REBUILD | rebuild_spawning | Shutdown    | priv-net-vxlan1=10.11.1.208, 172.31.250.240 |
+--------------------------------------+-----------------------------------------------------+---------+------------------+-------------+---------------------------------------------+



nova flavor-create --ephemeral 20 --swap 4  bdu.smt20.5c4t64g4swap100gd20ep auto 65536 100 20  --is-public=False
+--------------------------------------+---------------------------------+-----------+------+-----------+------+-------+-------------+-----------+
| ID                                   | Name                            | Memory_MB | Disk | Ephemeral | Swap | VCPUs | RXTX_Factor | Is_Public |
+--------------------------------------+---------------------------------+-----------+------+-----------+------+-------+-------------+-----------+
| 6c0cdfc1-d634-4315-b740-42ca2fbad53c | bdu.smt20.5c4t64g4swap100gd20ep | 65536     | 100  | 20        | 4    | 20    | 1.0         | False     |
+--------------------------------------+---------------------------------+-----------+------+-----------+------+-------+-------------+-----------+
nova  flavor-access-add 6c0cdfc1-d634-4315-b740-42ca2fbad53c 68993eec2c5e4931903bc949af53bff4
+--------------------------------------+----------------------------------+
| Flavor_ID                            | Tenant_ID                        |
+--------------------------------------+----------------------------------+
| 6c0cdfc1-d634-4315-b740-42ca2fbad53c | 68993eec2c5e4931903bc949af53bff4 |
+--------------------------------------+----------------------------------+
CPU_SOCKETS=5
CPU_CORES=1
CPU_THREADS=4
nova flavor-key bdu.smt20.5c4t64g4swap100gd20ep set hw:cpu_cores=${CPU_CORES} hw:cpu_sockets=${CPU_SOCKETS} hw:cpu_threads=${CPU_THREADS} 
nova flavor-key bdu.smt20.5c4t64g4swap100gd20ep set aggregate_instance_extra_specs:filter_tenant_id=68993eec2c5e4931903bc949af53bff4 

nova flavor-show bdu.smt20.5c4t64g4swap100gd20ep
+----------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Property                   | Value                                                                                                                                                      |
+----------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------+
| OS-FLV-DISABLED:disabled   | False                                                                                                                                                      |
| OS-FLV-EXT-DATA:ephemeral  | 20                                                                                                                                                         |
| disk                       | 100                                                                                                                                                        |
| extra_specs                | {"hw:cpu_cores": "1", "hw:cpu_threads": "4", "hw:cpu_sockets": "5", "aggregate_instance_extra_specs:filter_tenant_id": "68993eec2c5e4931903bc949af53bff4"} |
| id                         | 6c0cdfc1-d634-4315-b740-42ca2fbad53c                                                                                                                       |
| name                       | bdu.smt20.5c4t64g4swap100gd20ep                                                                                                                            |
| os-flavor-access:is_public | False                                                                                                                                                      |
| ram                        | 65536                                                                                                                                                      |
| rxtx_factor                | 1.0                                                                                                                                                        |
| swap                       | 4                                                                                                                                                          |
| vcpus                      | 20                                                                                                                                                         |
+----------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------+








