# create user

## creat user by db
```
insert into user (id,extra,enabled,default_project_id)  values('e786c108a9844b5ab9ac16a78e632c03','{"email": "linzhbj@cn.ibm.com"}','1','8fe6c73443844f13b5d0dd7735718e93');
MariaDB [keystone]> select * from user;
+----------------------------------+-----------------------------------+---------+----------------------------------+
| id                               | extra                             | enabled | default_project_id               |
+----------------------------------+-----------------------------------+---------+----------------------------------+
| 2494b270b63f4a3ca88494b7c7ea07e2 | {"email": "root@localhost"}       |       1 | NULL                             |
| 2729744b8b994f7981b7df1698df8774 | {"email": "cinder@localhost"}     |       1 | NULL                             |
| 2a7aa2e84f1f4b1da5bba4f3dd0c80a7 | {"email": "ironic@localhost"}     |       1 | NULL                             |
| 3e16517fe80c458986cf485759009749 | {"email": "neutron@localhost"}    |       1 | NULL                             |
| 4d22ba7a8c2e4703b3cb955d53eb30f6 | {"email": "heat_admin@localhost"} |       1 | NULL                             |
| 5edd19a51f8f4fcf91952ac4d983c70a | {"email": "glance@localhost"}     |       1 | NULL                             |
| 699ddb36ee6647f4925b607d1017b193 | {"email": "swift@localhost"}      |       1 | NULL                             |
| ad49010239bb44b1a20720c444488f2d | {"email": "nova@localhost"}       |       1 | NULL                             |
| e786c108a9844b5ab9ac16a78e632c03 | {"email": "linzhbj@cn.ibm.com"}   |       1 | 8fe6c73443844f13b5d0dd7735718e93 |
| e786c108a9844b5ab9ac16a78e632c06 | {"email": "linzhbj@cn.ibm.com"}   |       1 | 8fe6c73443844f13b5d0dd7735718e9c |
| fb1ee0239da34237b4907e5c4f5c649e | {"email": "heat@localhost"}       |       1 | NULL                             |
+----------------------------------+-----------------------------------+---------+----------------------------------+

insert into project (id,name,extra,description,enabled,domain_id,parent_id,is_domain) values('8fe6c73443844f13b5d0dd7735718e93','linzhbj2@cn.ibm.com','{}','linzhbj2@cn.ibm.com','1','default','default','0');

MariaDB [keystone]> select * from project;                                                                                                                                                              +----------------------------------+--------------------------+-------+-----------------------------------+---------+--------------------------+-----------+-----------+
| id                               | name                     | extra | description                       | enabled | domain_id                | parent_id | is_domain |
+----------------------------------+--------------------------+-------+-----------------------------------+---------+--------------------------+-----------+-----------+
| 7de3dec9204e4f52b704f391cd4413c4 | admin                    | {}    | admin tenant                      |       1 | default                  | default   |         0 |
| 8fe6c73443844f13b5d0dd7735718e93 | linzhbj2@cn.ibm.com      | {}    | linzhbj2@cn.ibm.com               |       1 | default                  | default   |         0 |
| 8fe6c73443844f13b5d0dd7735718e9c | linzhbj@cn.ibm.com       | {}    | linzhbj@cn.ibm.com                |       1 | default                  | default   |         0 |
| <<keystone.domain.root>>         | <<keystone.domain.root>> | {}    |                                   |       0 | <<keystone.domain.root>> | NULL      |         1 |
| c3009d4e1f9c4d01b8a6124458723b50 | services                 | {}    | Tenant for the openstack services |       1 | default                  | default   |         0 |
| default                          | Default                  | {}    | The default domain                |       1 | <<keystone.domain.root>> | NULL      |         1 |
| ff339fd5288b4d33a91f91a3024a93ab | heat                     | {}    |                                   |       1 | <<keystone.domain.root>> | NULL      |         1 |
+----------------------------------+--------------------------+-------+-----------------------------------+---------+--------------------------+-----------+-----------+

insert into local_user (id,user_id,domain_id,name) values(NULL,'e786c108a9844b5ab9ac16a78e632c03','default','linzhbj2@cn.ibm.com');
MariaDB [keystone]> select * from local_user;
+----+----------------------------------+----------------------------------+---------------------+
| id | user_id                          | domain_id                        | name                |
+----+----------------------------------+----------------------------------+---------------------+
|  1 | 2494b270b63f4a3ca88494b7c7ea07e2 | default                          | admin               |
|  2 | 3e16517fe80c458986cf485759009749 | default                          | neutron             |
|  3 | ad49010239bb44b1a20720c444488f2d | default                          | nova                |
|  4 | 5edd19a51f8f4fcf91952ac4d983c70a | default                          | glance              |
|  5 | 2a7aa2e84f1f4b1da5bba4f3dd0c80a7 | default                          | ironic              |
|  6 | 2729744b8b994f7981b7df1698df8774 | default                          | cinder              |
|  7 | 699ddb36ee6647f4925b607d1017b193 | default                          | swift               |
|  8 | fb1ee0239da34237b4907e5c4f5c649e | default                          | heat                |
|  9 | 4d22ba7a8c2e4703b3cb955d53eb30f6 | ff339fd5288b4d33a91f91a3024a93ab | heat_admin          |
| 13 | e786c108a9844b5ab9ac16a78e632c06 | default                          | linzhbj@cn.ibm.com  |
| 16 | e786c108a9844b5ab9ac16a78e632c03 | default                          | linzhbj2@cn.ibm.com |
+----+----------------------------------+----------------------------------+---------------------+
keystone user-list | grep linzhbj2@cn.ibm.com  # ok

insert into password (id,local_user_id,password) values('16','16','$6$rounds=10000$cO/J5ygiQoUtW5/S$QUY4kHRYtXPHMiRA47shNi7FNUuw4pEa98kN6p59XBRGBGbXS8k9QRwU4noyWtvl8Jfa7mX4Mw9I3.MB2kyLl.');
MariaDB [keystone]> select * from password;
+----+---------------+-------------------------------------------------------------------------------------------------------------------------+
| id | local_user_id | password                                                                                                                |
+----+---------------+-------------------------------------------------------------------------------------------------------------------------+
|  1 |             1 | $6$rounds=10000$GrRT1O7eJiSUTnaa$KVy.STTPxGazuBv1xWCJUBzaZ8SAQUoJcXE9Ci.zVsqJtSArfn.YEs6MEhIJuMLWtBAIkiZVsA0Ya5n8cly/20 |
|  2 |             2 | $6$rounds=10000$hW.wLBFc0C1v4HFm$D1usMtpQgW4i0V.pXDIIl2RMB2aqsC1EHiMzXSOsF7ZnZ6qWdzfmQZziUBP3xGJc2xlXf6v54hXO6lmGwma2C/ |
|  3 |             3 | $6$rounds=10000$wr1Zoxf1r2IUVFLO$N/QfVghgTB2ouhYbP01iF82.vLmCC36gU3TuPUNzdYyZzg2AJnDQ/9cDjP51/ONqgnQYwMjSQwK/ZgJ15xwtp/ |
|  4 |             4 | $6$rounds=10000$gS3agIjxHWXwRcCZ$uQ2CxVScc.3gutkDU3rWsEImNQlCNM5PvtLI2mS121JvitwjTpOB5ELi/juxdNrN.QndEALx/2N2yiIHWnY5l1 |
|  5 |             5 | $6$rounds=10000$5wh5oF9L/oO2GkXS$0c1TMLJ1iBBsd5Ooohdbr5q0bWluoJBbUKuQ5nBd4XCU7zOw/EnBZdprCSRcnWwMKeBwQiqNfSzy/uTyP7hEl. |
|  6 |             6 | $6$rounds=10000$eAAbRCoNmAjeAPjt$6HCvaleXGdMmh7uxzBXa7BsK1JTiwYWWghJtWBO2eJsi6x0SVdObrZA9iypSEzkWYReeULlZlhZLelYHVEABu0 |
|  7 |             7 | $6$rounds=10000$a9rIN86P7t5tTL6.$DwsVzuSwIq8r291zvntRA/VviauHPUy1mWKPW1/BpkWi8VtAQQeo9N0CpYAr6/tFUe0jgETm5Vn6VO5tqVtH9/ |
|  8 |             8 | $6$rounds=10000$Me2d91MsQ2qqggKq$SD9nuWSnQbVCPzdAKPBZRBn99PVvGXVuwasggLQhggc939kzo3XhuDtOZFa2sE71kE9RdLHgidlgB5H6FWxl00 |
|  9 |             9 | $6$rounds=10000$BLD8N43nZ1Mef2b6$CklhhRguFxAYqRViL/v.M1veZlsK4tYqF3BfeS9BkNmpzSisBnLyMmFhNURoSRSRMIQO5g7DBlPPTJx8IASVr/ |
| 13 |            13 | $6$rounds=10000$cO/J5ygiQoUtW5/S$QUY4kHRYtXPHMiRA47shNi7FNUuw4pEa98kN6p59XBRGBGbXS8k9QRwU4noyWtvl8Jfa7mX4Mw9I3.MB2kyLl. |
+----+---------------+-------------------------------------------------------------------------------------------------------------------------+

insert into assignment (type,actor_id,target_id,role_id,inherited) values('UserProject','e786c108a9844b5ab9ac16a78e632c03','8fe6c73443844f13b5d0dd7735718e93','9fe2ff9ee4384b1894a90878d3e92bab','0');
MariaDB [keystone]> select * from assignment;
+-------------+----------------------------------+----------------------------------+----------------------------------+-----------+
| type        | actor_id                         | target_id                        | role_id                          | inherited |
+-------------+----------------------------------+----------------------------------+----------------------------------+-----------+
| UserProject | 2494b270b63f4a3ca88494b7c7ea07e2 | 7de3dec9204e4f52b704f391cd4413c4 | 422971cc67514c48a198003b6a685333 |         0 |
| UserProject | 2494b270b63f4a3ca88494b7c7ea07e2 | 7de3dec9204e4f52b704f391cd4413c4 | 4edd9f770a284d70a2cff10221318423 |         0 |
| UserProject | 2494b270b63f4a3ca88494b7c7ea07e2 | 7de3dec9204e4f52b704f391cd4413c4 | 9fe2ff9ee4384b1894a90878d3e92bab |         0 |
| UserProject | 2729744b8b994f7981b7df1698df8774 | c3009d4e1f9c4d01b8a6124458723b50 | 4edd9f770a284d70a2cff10221318423 |         0 |
| UserProject | 2a7aa2e84f1f4b1da5bba4f3dd0c80a7 | c3009d4e1f9c4d01b8a6124458723b50 | 4edd9f770a284d70a2cff10221318423 |         0 |
| UserProject | 3e16517fe80c458986cf485759009749 | c3009d4e1f9c4d01b8a6124458723b50 | 4edd9f770a284d70a2cff10221318423 |         0 |
| UserProject | 5edd19a51f8f4fcf91952ac4d983c70a | c3009d4e1f9c4d01b8a6124458723b50 | 4edd9f770a284d70a2cff10221318423 |         0 |
| UserProject | 699ddb36ee6647f4925b607d1017b193 | c3009d4e1f9c4d01b8a6124458723b50 | 4edd9f770a284d70a2cff10221318423 |         0 |
| UserProject | ad49010239bb44b1a20720c444488f2d | c3009d4e1f9c4d01b8a6124458723b50 | 4edd9f770a284d70a2cff10221318423 |         0 |
| UserProject | e786c108a9844b5ab9ac16a78e632c03 | 8fe6c73443844f13b5d0dd7735718e93 | 9fe2ff9ee4384b1894a90878d3e92bab |         0 |
| UserProject | e786c108a9844b5ab9ac16a78e632c06 | 8fe6c73443844f13b5d0dd7735718e9c | 9fe2ff9ee4384b1894a90878d3e92bab |         0 |
| UserProject | fb1ee0239da34237b4907e5c4f5c649e | c3009d4e1f9c4d01b8a6124458723b50 | 4edd9f770a284d70a2cff10221318423 |         0 |
| UserDomain  | 4d22ba7a8c2e4703b3cb955d53eb30f6 | ff339fd5288b4d33a91f91a3024a93ab | 4edd9f770a284d70a2cff10221318423 |         0 |
+-------------+----------------------------------+----------------------------------+----------------------------------+-----------+
13 rows in set (0.00 sec)


keystone  user-password-update --pass passw0rd linzhbj2@cn.ibm.com

keystone user-list
keystone tenant-list
keystone user-role-list
keystone user-get e786c108a9844b5ab9ac16a78e632c03
keystone tenant-get 8fe6c73443844f13b5d0dd7735718e93

keystone user-role-list --user-id e786c108a9844b5ab9ac16a78e632c03 --tenant-id 8fe6c73443844f13b5d0dd7735718e93


mysqldump --opt -uroot -pclouddbpw keystone > keystone.sql
vim keystone.sql

source /root/openrc 
nova list
nova secgroup-list-rules default

```
