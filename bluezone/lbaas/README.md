

neutron lb-pool-create --name lb-pool --lb-method ROUND_ROBIN --protocol HTTP --subnet-id 1bbb948c-d7f6-433e-804d-ca04d274007f
neutron lb-pool-list
neutron lb-vip-list
neutron lb-vip-create --name asr-vip --protocol-port 80 --protocol HTTP --subnet-id 1bbb948c-d7f6-433e-804d-ca04d274007f lb-pool
neutron lb-vip-list
nova list
neutron lb-member-create --address 10.71.2.59 --protocol-port 80 lb-pool
neutron lb-member-create --address 10.71.2.58 --protocol-port 80 lb-pool
neutron lb-member-list
nova floating-ip-list
nova floating-ip-create
nova floating-ip-create ext-vlan
nova floating-ip-create ext——vlan
nova floating-ip-create ext_vlan
neutron net-list
nova floating-ip-create ext_net
neutron port-list | grep 114
neutron floatingip-associate
neutron floatingip-associate 04dd4e9c-aacf-478f-9843-c65ce8bbfaed 54d1f7a6-b90a-4025-ac32-5b61d067d30d
neutron lb-healthmonitor-list
neutron lb-healthmonitor-associate lb-pool
neutron lb-healthmonitor-associate 23456653-0312-4236-ab53-de1ecfb7ac74 lb-pool

