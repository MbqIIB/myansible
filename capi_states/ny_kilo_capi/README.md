# deploy capi

# deploy svp13

``` shell
svp13
cd /usr/lib/python2.7/dist-packages/
tar  cvf svp13_nova.20170519.tar.gz  nova

/usr/lib/python2.7/dist-packages/nova/api/openstack/compute/servers.py svp9_nova/api/openstack/compute/servers.py
/usr/lib/python2.7/dist-packages/nova/compute/api.py                   svp9_nova/compute/api.py
/usr/lib/python2.7/dist-packages/nova/compute/gpu_states.py            svp9_nova/compute/gpu_states.py
/usr/lib/python2.7/dist-packages/nova/compute/manager.py               svp9_nova/compute/manager.py
/usr/lib/python2.7/dist-packages/nova/compute/resource_tracker.py      svp9_nova/compute/resource_tracker.py
/usr/lib/python2.7/dist-packages/nova/compute/rpcapi.py                svp9_nova/compute/rpcapi.py
/usr/lib/python2.7/dist-packages/nova/objects/compute_node.py          svp9_nova/objects/compute_node.py



scp /usr/lib/python2.7/dist-packages/nova/api/openstack/compute/servers.py svp13:/usr/lib/python2.7/dist-packages/nova/api/openstack/compute/servers.py
scp /usr/lib/python2.7/dist-packages/nova/compute/api.py                   svp13:/usr/lib/python2.7/dist-packages/nova/compute/api.py
scp /usr/lib/python2.7/dist-packages/nova/compute/gpu_states.py            svp13:/usr/lib/python2.7/dist-packages/nova/compute/gpu_states.py
scp /usr/lib/python2.7/dist-packages/nova/compute/manager.py               svp13:/usr/lib/python2.7/dist-packages/nova/compute/manager.py
scp /usr/lib/python2.7/dist-packages/nova/compute/resource_tracker.py      svp13:/usr/lib/python2.7/dist-packages/nova/compute/resource_tracker.py
scp /usr/lib/python2.7/dist-packages/nova/compute/rpcapi.py                svp13:/usr/lib/python2.7/dist-packages/nova/compute/rpcapi.py
scp /usr/lib/python2.7/dist-packages/nova/objects/compute_node.py          svp13:/usr/lib/python2.7/dist-packages/nova/objects/compute_node.py

vim /usr/lib/python2.7/dist-packages/nova/compute/capi_states.py
capi_dev_board = "Alphadata-8K5"


root@svp13:~# scp svp9:/usr/bin/capi* /usr/bin/
capi_flash.sh                                                                                                                                                         100% 1679     1.6KB/s   00:00    
capi_flash_xilinx_ad                                                                                                                                                  100%   70KB  70.3KB/s   00:00    
capi_reset.sh  

vim /usr/bin/capi_flash.sh

vim /usr/bin/capi_reset.sh
echo "quit by linzhbj"
exit 0

[root@bluezone-ctl43 ~]# mysql -uroot -p6I9LIVgbdrLTeBgu -e "select host,extra_resources from nova.compute_nodes where host='svp9';"
+------+-----------------------------------------------------------------------------+
| host | extra_resources                                                             |
+------+-----------------------------------------------------------------------------+
| svp9 | {"fpga_capi": {"afu0": ["Alphadata-KU3", 0], "afu1": ["Alphadata-KU3", 0]}} |
+------+-----------------------------------------------------------------------------+
[root@bluezone-ctl43 ~]# mysql -uroot -p6I9LIVgbdrLTeBgu -e "select host,extra_resources from nova.compute_nodes where host='svp13';"
+-------+-----------------------------------------------------------------------------+
| host  | extra_resources                                                             |
+-------+-----------------------------------------------------------------------------+
| svp13 | {"fpga_capi": {"afu0": ["Alphadata-8K5", 0], "afu1": ["Alphadata-8K5", 0]}} |
| svp13 | NULL                                                                        |
+-------+-----------------------------------------------------------------------------+


[root@bluezone-ctl43 ~]# mysql -uroot -p6I9LIVgbdrLTeBgu -e "select id,host,extra_resources from nova.compute_nodes where id='46'  ;"
+----+-------+-----------------+
| id | host  | extra_resources |
+----+-------+-----------------+
| 46 | svp13 | NULL            |
+----+-------+-----------------+
[root@bluezone-ctl43 ~]# mysql -uroot -p6I9LIVgbdrLTeBgu -e "delete from nova.compute_nodes where id='46'  ;"
[root@bluezone-ctl43 ~]# mysql -uroot -p6I9LIVgbdrLTeBgu -e "select id,host,extra_resources from nova.compute_nodes where host='svp13'  ;"
+----+-------+-----------------------------------------------------------------------------+
| id | host  | extra_resources                                                             |
+----+-------+-----------------------------------------------------------------------------+
| 48 | svp13 | {"fpga_capi": {"afu0": ["Alphadata-8K5", 0], "afu1": ["Alphadata-8K5", 0]}} |
+----+-------+-----------------------------------------------------------------------------+



[root@bluezone-ctl43 ~]# scp chenfei/upload-CAPI.sh svp13:/root/wangjs/
upload-CAPI.sh      

```

