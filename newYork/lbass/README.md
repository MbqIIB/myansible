

NameSuffix=lintest
SubnetID=f4250ae1-36c5-499c-8c38-151d8ec8dc2f
Port=80
Protocol=TCP

neutron lb-pool-create --name lb-${NameSuffix} --lb-method ROUND_ROBIN --protocol ${Protocol} --subnet-id ${SubnetID}

neutron lb-vip-create --name vip-${NameSuffix} --protocol-port ${Port} --protocol ${Protocol} --subnet-id ${SubnetID} lb-${NameSuffix}


Address=( \
          10.0.45.72 \
          10.0.45.73 \
        )

for ip in ${Address[@]}
do
    echo $ip
    neutron lb-member-create --address $ip --protocol-port ${Port} lb-${NameSuffix}
done

PublicID=32670b8e-e0eb-4cb9-8c58-10c779d3bb17

 neutron floatingip-create ${PublicID}

neutron floatingip-associate  ${floatingipid} ${portid}

neutron lb-pool-list  --tenant-id 461ac8f4615746a59a88d66427448fdd
neutron lb-pool-update --lb-method SOURCE_IP  lb-BlueScan --tenant-id 461ac8f4615746a59a88d66427448fdd

neutron lb-pool-update 57c6384e-2eff-4c86-b283-025c6f930802 --lb-method SOURCE_IP

neutron help lb-pool-create | grep "lb-method"
[--description DESCRIPTION] --lb-method
--lb-method {ROUND_ROBIN,LEAST_CONNECTIONS,SOURCE_IP}

