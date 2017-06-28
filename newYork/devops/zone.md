# zone
Minsky-az

``` shell
ref [https://www.brad-x.com/2016/01/01/dedicate-compute-hosts-to-projects/]
https://ask.openstack.org/en/question/91040/limit-which-availability-zone-a-project-can-use/
https://blueprints.launchpad.net/nova/+spec/multi-tenancy-aggregates


nova aggregate-create DedicatedCompute
nova aggregate-add-host DedicatedCompute dedicated-compute-host1
nova aggregate-add-host DedicatedCompute dedicated-compute-host2
nova aggregate-add-host DedicatedCompute dedicated-compute-host3


nova aggregate-set-metadata DedicatedCompute filter_tenant_id=<Tenant ID Here>



nova aggregate-create lintest lintest-az
nova aggregate-add-host lintest fnode6-7

keystone tenant-list | grep "linzhbj@cn.ibm.com"
tid=4b574b27b5e44664aab81b1a9edd128a

nova aggregate-set-metadata lintest filter_tenant_id=4b574b27b5e44664aab81b1a9edd128a


nova flavor-key devops.docker.medium set aggregate_instance_extra_specs:filter_tenant_id=4b574b27b5e44664aab81b1a9edd128a
nova flavor-show devops.docker.medium

nova availability-zone-list


```
