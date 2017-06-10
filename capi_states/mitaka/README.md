
# deploy gpu in mitaka

git clone git@github.ibm.com:sv-gpu/nova-kvm-gpu.git

### ctl
/usr/lib/python2.7/site-packages/nova/scheduler/filters/compute_filter.py


### fnode3-6 ubuntu mitaka compute
```shell
node=fnode6-7
node=fnode2-7
ssh ${node}
mkdir -p /var/lib/gpu
chown nova:nova -R /var/lib/gpu 
scp /var/lib/gpu/gpu_locked.txt ${node}://var/lib/gpu/gpu_locked.txt
scp /usr/lib/python2.7/dist-packages/nova/compute/gpu_states.py  ${node}:/usr/lib/python2.7/dist-packages/nova/compute/
scp /usr/lib/python2.7/dist-packages/nova/compute/gpu_volume.py  ${node}:/usr/lib/python2.7/dist-packages/nova/compute/
scp /usr/lib/python2.7/dist-packages/nova/compute/resource_tracker.py ${node}:/usr/lib/python2.7/dist-packages/nova/compute/
scp /usr/lib/python2.7/dist-packages/nova/gpus_kvm.py ${node}:/usr/lib/python2.7/dist-packages/nova/gpus_kvm.py
```


scp fnode3-6:/usr/lib/python2.7/dist-packages/nova/compute/gpu_*  .
gpu_states.py                                                                                                                                                                100%   28KB  27.7KB/s   00:00
gpu_volume.py                    

scp fnode3-6:/usr/lib/python2.7/dist-packages/nova/gpus_kvm.py .



# update mysql db
```
[root@ctl-n1 ~]# mysql -u root -e "select extra_resources,host from nova.compute_nodes where host='fnode2-7'"
+-----------------+----------+
| extra_resources | host     |
+-----------------+----------+
| NULL            | fnode2-7 |

+-----------------+----------+




mysql -u root -e "update  nova.compute_nodes set extra_resources='4' where host='fnode2-7'"

[root@ctl-n1 ~]# mysql -u root -e "update  nova.compute_nodes set extra_resources='4' where host='fnode2-7'"
[root@ctl-n1 ~]# mysql -u root -e "select extra_resources,host from nova.compute_nodes where host='fnode2-7'"
+-----------------+----------+
| extra_resources | host     |
+-----------------+----------+
| 4               | fnode2-7 |
+-----------------+----------+

```

# cess x86 centos
```
scp gpu_volume.py svx7:/usr/lib/python2.7/site-packages/nova/compute/
```
