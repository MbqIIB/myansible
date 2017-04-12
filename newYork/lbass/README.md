

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




neutron lb-vip-update 3c7ed70f-da95-49b4-b460-67542e63df48  --pool-id 57c6384e-2eff-4c86-b283-025c6f930802 --session-persistence-disable



neutron lb-pool-update f0309b23-e803-4f1e-bc31-6c6998c4313b --lb-method ROUND_ROBIN

[root@ansible lbass]# neutron lb-pool-update f0309b23-e803-4f1e-bc31-6c6998c4313b --lb-method ROUND_ROBIN
Updated pool: f0309b23-e803-4f1e-bc31-6c6998c4313b
[root@ansible lbass]# neutron lb-pool-list
+--------------------------------------+-----------------+----------+-------------+----------+----------------+--------+
| id                                   | name            | provider | lb_method   | protocol | admin_state_up | status |
+--------------------------------------+-----------------+----------+-------------+----------+----------------+--------+
| 57c6384e-2eff-4c86-b283-025c6f930802 | lb-BlueScan     | haproxy  | SOURCE_IP   | TCP      | True           | ACTIVE |
| e1993514-dd48-4ee6-bb9d-236820170e30 | lb-lintest      | haproxy  | ROUND_ROBIN | TCP      | True           | ACTIVE |
| f0309b23-e803-4f1e-bc31-6c6998c4313b | lb-BlueScan8081 | haproxy  | ROUND_ROBIN | HTTP     | True           | ACTIVE |
+--------------------------------------+-----------------+----------+-------------+----------+----------------+--------+



https://www.ibm.com/developerworks/community/blogs/132cfa78-44b0-4376-85d0-d3096cd30d3f/entry/%E5%88%9B%E5%BB%BA_Pool_VIP_%E6%AF%8F%E5%A4%A95%E5%88%86%E9%92%9F%E7%8E%A9%E8%BD%AC_OpenStack_122?lang=en

neutron lb-healthmonitor-create --tenant-id  461ac8f4615746a59a88d66427448fdd \
            --expected-codes 200 --http-method GET --url-path "http://172.29.163.140:8081/bluescan"  --delay 3 --type HTTP --max-retries  5 



             neutron lb-healthmonitor-create --tenant-id  461ac8f4615746a59a88d66427448fdd             --expected-codes 200 --http-method GET --url-path "http://172.29.163.140:8081/bluescan"  --delay 3 --type HTTP --max-retries  5 --timeout 3
             Created a new health_monitor:
             +----------------+--------------------------------------+
             | Field          | Value                                |
             +----------------+--------------------------------------+
             | admin_state_up | True                                 |
             | delay          | 3                                    |
             | expected_codes | 200                                  |
             | http_method    | GET                                  |
             | id             | b1a7e451-2b52-4098-a663-cb8fe4f40f24 |
             | max_retries    | 5                                    |
             | pools          |                                      |
             | tenant_id      | 461ac8f4615746a59a88d66427448fdd     |
             | timeout        | 3                                    |
             | type           | HTTP                                 |
             | url_path       | http://172.29.163.140:8081/bluescan  |
             +----------------+--------------------------------------+

 neutron lb-healthmonitor-list
 +--------------------------------------+------+----------------+
 | id                                   | type | admin_state_up |
 +--------------------------------------+------+----------------+
 | b1a7e451-2b52-4098-a663-cb8fe4f40f24 | HTTP | True           |
 +--------------------------------------+------+----------------+
 [root@ansible lbass]# neutron lb-pool-list
 +--------------------------------------+-----------------+----------+-------------+----------+----------------+--------+
 | id                                   | name            | provider | lb_method   | protocol | admin_state_up | status |
 +--------------------------------------+-----------------+----------+-------------+----------+----------------+--------+
 | 57c6384e-2eff-4c86-b283-025c6f930802 | lb-BlueScan     | haproxy  | SOURCE_IP   | TCP      | True           | ACTIVE |
 | e1993514-dd48-4ee6-bb9d-236820170e30 | lb-lintest      | haproxy  | ROUND_ROBIN | TCP      | True           | ACTIVE |
 | f0309b23-e803-4f1e-bc31-6c6998c4313b | lb-BlueScan8081 | haproxy  | ROUND_ROBIN | HTTP     | True           | ACTIVE |
 +--------------------------------------+-----------------+----------+-------------+----------+----------------+--------+


 neutron lb-healthmonitor-associate b1a7e451-2b52-4098-a663-cb8fe4f40f24 f0309b23-e803-4f1e-bc31-6c6998c4313b
 Associated health monitor b1a7e451-2b52-4098-a663-cb8fe4f40f24

 [root@ansible lbass]# neutron  lb-healthmonitor-show b1a7e451-2b52-4098-a663-cb8fe4f40f24
 +----------------+-----------------------------------------------------------------------------------------------------+
 | Field          | Value                                                                                               |
 +----------------+-----------------------------------------------------------------------------------------------------+
 | admin_state_up | True                                                                                                |
 | delay          | 3                                                                                                   |
 | expected_codes | 200                                                                                                 |
 | http_method    | GET                                                                                                 |
 | id             | b1a7e451-2b52-4098-a663-cb8fe4f40f24                                                                |
 | max_retries    | 5                                                                                                   |
 | pools          | {"status": "ACTIVE", "status_description": null, "pool_id": "f0309b23-e803-4f1e-bc31-6c6998c4313b"} |
 | tenant_id      | 461ac8f4615746a59a88d66427448fdd                                                                    |
 | timeout        | 3                                                                                                   |
 | type           | HTTP                                                                                                |
 | url_path       | http://172.29.163.140:8081/bluescan                                                                 |
 +----------------+-----------------------------------------------------------------------------------------------------+


  neutron lb-healthmonitor-update --url-path='/bluescan' b1a7e451-2b52-4098-a663-cb8fe4f40f24

  neutron lb-healthmonitor-update --url-path='/bluescan/login.jsp' b1a7e451-2b52-4098-a663-cb8fe4f40f24


  ref:

https://www.rdoproject.org/networking/lbaas/

https://docs.openstack.org/cli-reference/neutron.html
https://wiki.openstack.org/wiki/Neutron/LBaaS/CLI

https://www.ibm.com/developerworks/community/blogs/132cfa78-44b0-4376-85d0-d3096cd30d3f/entry/%E5%88%9B%E5%BB%BA_Pool_VIP_%E6%AF%8F%E5%A4%A95%E5%88%86%E9%92%9F%E7%8E%A9%E8%BD%AC_OpenStack_122?lang=en



