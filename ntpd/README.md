
ansible poc-server -m shell -a "date"


ansible install-server -m shell -a "date"

ansible compute-server -m shell -a "date"


#### set time zone
``` shell
[root@ent-ansible-x86 ntpd]#  timedatectl  list-timezones | grep hai
Asia/Shanghai
[root@ent-ansible-x86 ntpd]#

timedatectl  set-timezone "Asia/Shanghai"
hwclock -w
```
