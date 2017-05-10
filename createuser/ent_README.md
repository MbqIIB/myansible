# create main keystone user  to ent user  for openstack kilo

```shell
keystone tenant-create --name kongkh@cn.ibm.com 
+-------------+----------------------------------+
|   Property  |              Value               |
+-------------+----------------------------------+
| description |                                  |
|   enabled   |               True               |
|      id     | 198d754427b343ad89bcbb7e988af990 |
|     name    |        kongkh@cn.ibm.com         |
+-------------+----------------------------------+

keystone user-create --name kongkh@cn.ibm.com  --tenant 198d754427b343ad89bcbb7e988af990  --pass KONGHAO0729 --email kongkh@cn.ibm.com
+----------+----------------------------------+
| Property |              Value               |
+----------+----------------------------------+
|  email   |        kongkh@cn.ibm.com         |
| enabled  |               True               |
|    id    | b41716ccebe348e9adbf333efa489d04 |
|   name   |        kongkh@cn.ibm.com         |
| tenantId | 198d754427b343ad89bcbb7e988af990 |
| username |        kongkh@cn.ibm.com         |
+----------+----------------------------------+

# ent user
mysql -e 'select * from keystone.user where id="b41716ccebe348e9adbf333efa489d04";' -popenstack1 
mysql -e 'select * from keystone.project where id="198d754427b343ad89bcbb7e988af990";' -popenstack1 


# update ent user to main user

mysql -e 'update keystone.user set default_project_id="78f7fc31ffac4c16b2b96c198f264b2c" where id="b41716ccebe348e9adbf333efa489d04";'  -popenstack1
mysql -e 'update keystone.user set id="9d385b57f87742ddb98a9868f2624b32" where id="b41716ccebe348e9adbf333efa489d04";'  -popenstack1
mysql -e 'update keystone.project set id="78f7fc31ffac4c16b2b96c198f264b2c" where id="198d754427b343ad89bcbb7e988af990";'  -popenstack1

# check updated main user
mysql -e 'select * from keystone.user where id="9d385b57f87742ddb98a9868f2624b32";' -popenstack1 
mysql -e 'select * from keystone.project where id="78f7fc31ffac4c16b2b96c198f264b2c";' -popenstack1 

# check role
keystone user-role-list --tenant 78f7fc31ffac4c16b2b96c198f264b2c --user 9d385b57f87742ddb98a9868f2624b32

# add default role _member
keystone user-role-add --tenant 78f7fc31ffac4c16b2b96c198f264b2c --user 9d385b57f87742ddb98a9868f2624b32 --role _member_

# second check
keystone user-role-list --tenant 198d754427b343ad89bcbb7e988af990 --user  b41716ccebe348e9adbf333efa489d04


# check old assignment
mysql -e 'select *  from keystone.assignment where actor_id="b41716ccebe348e9adbf333efa489d04";' -popenstack1

# delete old assignment
mysql -e 'delete  from keystone.assignment where actor_id="b41716ccebe348e9adbf333efa489d04";'  -popenstack1

# check old assignment
mysql -e 'select * from keystone.assignment where actor_id="9d385b57f87742ddb98a9868f2624b32";' -popenstack1 
+-------------+----------------------------------+----------------------------------+----------------------------------+-----------+
| type        | actor_id                         | target_id                        | role_id                          | inherited |
+-------------+----------------------------------+----------------------------------+----------------------------------+-----------+
| UserProject | 9d385b57f87742ddb98a9868f2624b32 | 78f7fc31ffac4c16b2b96c198f264b2c | 9fe2ff9ee4384b1894a90878d3e92bab |         0 |
+-------------+----------------------------------+----------------------------------+----------------------------------+-----------+
```

