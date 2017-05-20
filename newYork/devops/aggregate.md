

nova aggregate-create BDU BDU-az 
nova aggregate-add-host BDU fnode2-7
nova aggregate-add-host BDU fnode2-5

68993eec2c5e4931903bc949af53bff4

nova aggregate-set-metadata BDU  filter_tenant_id=68993eec2c5e4931903bc949af53bff4
[(DevOps)root@ansible ~]# nova aggregate-set-metadata BDU  filter_tenant_id=68993eec2c5e4931903bc949af53bff4
Metadata has been successfully updated for aggregate 8.
+----+------+-------------------+------------------------+---------------------------------------------------------------------------------+
| Id | Name | Availability Zone | Hosts                  | Metadata                                                                        |
+----+------+-------------------+------------------------+---------------------------------------------------------------------------------+
| 8  | BDU  | BDU-az            | 'fnode2-7', 'fnode2-5' | 'availability_zone=BDU-az', 'filter_tenant_id=68993eec2c5e4931903bc949af53bff4' |
+----+------+-------------------+------------------------+---------------------------------------------------------------------------------+


[(DevOps)root@ansible flavor]# nova flavor-create devops.docker.medium auto 4096 40 2

+--------------------------------------+----------------------+-----------+------+-----------+------+-------+-------------+-----------+
| ID                                   | Name                 | Memory_MB | Disk | Ephemeral | Swap | VCPUs | RXTX_Factor | Is_Public |
+--------------------------------------+----------------------+-----------+------+-----------+------+-------+-------------+-----------+
| 1914ae6e-e482-45c7-a52e-c0bc0c9fd0d6 | devops.docker.medium | 4096      | 40   | 0         |      | 2     | 1.0         | True      |
+--------------------------------------+----------------------+-----------+------+-----------+------+-------+-------------+-----------+


nova flavor-create bdu.smt20.5c4t64g100gd    auto 65536 100 20

[(DevOps)root@ansible flavor]# nova flavor-create bdu.smt20.5c4t64g100gd    auto 65536 100 20
+--------------------------------------+------------------------+-----------+------+-----------+------+-------+-------------+-----------+
| ID                                   | Name                   | Memory_MB | Disk | Ephemeral | Swap | VCPUs | RXTX_Factor | Is_Public |
+--------------------------------------+------------------------+-----------+------+-----------+------+-------+-------------+-----------+
| 7d64d3a1-3f46-458a-856d-a7c85cb2174f | bdu.smt20.5c4t64g100gd | 65536     | 100  | 0         |      | 20    | 1.0         | True      |
+--------------------------------------+------------------------+-----------+------+-----------+------+-------+-------------+-----------+

CPU_SOCKETS=5
CPU_CORES=1
CPU_THREADS=4
nova flavor-key bdu.smt20.5c4t64g100gd set hw:cpu_cores=${CPU_CORES} hw:cpu_sockets=${CPU_SOCKETS} hw:cpu_threads=${CPU_THREADS}

[(DevOps)root@ansible flavor]# nova flavor-show bdu.smt20.5c4t64g100gd
+----------------------------+---------------------------------------------------------------------+
| Property                   | Value                                                               |
+----------------------------+---------------------------------------------------------------------+
| OS-FLV-DISABLED:disabled   | False                                                               |
| OS-FLV-EXT-DATA:ephemeral  | 0                                                                   |
| disk                       | 100                                                                 |
| extra_specs                | {"hw:cpu_cores": "1", "hw:cpu_threads": "4", "hw:cpu_sockets": "5"} |
| id                         | 7d64d3a1-3f46-458a-856d-a7c85cb2174f                                |
| name                       | bdu.smt20.5c4t64g100gd                                              |
| os-flavor-access:is_public | True                                                                |
| ram                        | 65536                                                               |
| rxtx_factor                | 1.0                                                                 |
| swap                       |                                                                     |
| vcpus                      | 20                                                                  |
+----------------------------+---------------------------------------------------------------------+

nova flavor-key bdu.smt20.5c4t64g100gd set aggregate_instance_extra_specs:filter_tenant_id=68993eec2c5e4931903bc949af53bff4
[(DevOps)root@ansible flavor]# nova flavor-show bdu.smt20.5c4t64g100gd
+----------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Property                   | Value                                                                                                                                                      |
+----------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------+
| OS-FLV-DISABLED:disabled   | False                                                                                                                                                      |
| OS-FLV-EXT-DATA:ephemeral  | 0                                                                                                                                                          |
| disk                       | 100                                                                                                                                                        |
| extra_specs                | {"hw:cpu_cores": "1", "hw:cpu_threads": "4", "hw:cpu_sockets": "5", "aggregate_instance_extra_specs:filter_tenant_id": "68993eec2c5e4931903bc949af53bff4"} |
| id                         | 7d64d3a1-3f46-458a-856d-a7c85cb2174f                                                                                                                       |
| name                       | bdu.smt20.5c4t64g100gd                                                                                                                                     |
| os-flavor-access:is_public | True                                                                                                                                                       |
| ram                        | 65536                                                                                                                                                      |
| rxtx_factor                | 1.0                                                                                                                                                        |
| swap                       |                                                                                                                                                            |
| vcpus                      | 20                                                                                                                                                         |
+----------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------+



