

pcs cluster start poc-ctl0
pcs cluster start poc-ctl1
pcs cluster start poc-ctl2


/usr/bin/galera_new_cluster

pcs resource
pcs cluster unstandby --all


  355  2016-11-15 03:46:58 scp setupctl.sh poc-ctl1:/root/scripts/
  356  2016-11-15 03:46:58 scp setupctl.sh poc-ctl2:/root/scripts/
  357  2016-11-15 03:46:58 ls
  358  2016-11-15 03:46:58 mysql -u root -e "SHOW STATUS LIKE 'wsrep%';"
  359  2016-11-15 03:46:58 pcs cluster auth poc-ctl0 poc-ctl1 poc-ctl2
  360  2016-11-15 03:46:58 pcs cluster setup --start --name openstack_cluster poc-ctl0 poc-ctl1 poc-ctl2
/cluster                                                                                                     
