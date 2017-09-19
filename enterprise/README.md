#### for test
```shell
ansible cfc-server-test -m shell -a 'date'
```
# ipmi
```
ipmitool -I lanplus -H 172.16.10.72 -U USERID -P SV@crl123 power status
ipmitool -I lanplus -H 172.16.10.75 -U USERID -P SV@crl123 power status
https://172.16.10.72 
https://172.16.10.75
```
