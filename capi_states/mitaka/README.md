
# deploy gpu in mitaka

git clone git@github.ibm.com:sv-gpu/nova-kvm-gpu.git

### ctl
/usr/lib/python2.7/site-packages/nova/scheduler/filters/compute_filter.py


###fnode3-6 ubuntu mitaka compute
```shell
scp /var/lib/gpu/gpu_locked.txt fnode6-7://var/lib/gpu/gpu_locked.txt
scp /usr/lib/python2.7/dist-packages/nova/compute/gpu_states.py  fnode6-7:/usr/lib/python2.7/dist-packages/nova/compute/
scp /usr/lib/python2.7/dist-packages/nova/compute/gpu_volume.py  fnode6-7:/usr/lib/python2.7/dist-packages/nova/compute/
scp /usr/lib/python2.7/dist-packages/nova/compute/resource_tracker.py fnode6-7:/usr/lib/python2.7/dist-packages/nova/compute/
scp /usr/lib/python2.7/dist-packages/nova/gpus_kvm.py fnode6-7:/usr/lib/python2.7/dist-packages/nova/gpus_kvm.py
```


scp fnode3-6:/usr/lib/python2.7/dist-packages/nova/compute/gpu_*  .
gpu_states.py                                                                                                                                                                100%   28KB  27.7KB/s   00:00
gpu_volume.py                    

scp fnode3-6:/usr/lib/python2.7/dist-packages/nova/gpus_kvm.py .


