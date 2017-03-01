

##### sort

```
/etc/neutron/neutron.conf
allow_sorting = True
service neutron-server restart

neutron floatingip-list --sort-key floating_ip_address --sort-dir asc
```


