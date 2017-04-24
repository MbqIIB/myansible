
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



ansible poc-server -m shell -a "date"
systemctl enable ntpd
systemctl start ntpd
systemctl status ntpd

ansible all -m shell -a "date"
timedatectl  set-timezone "Asia/Shanghai"

```

##check dir
ls -ld /var/log/ntpstats
drwxr-xr-x. 2 ntp ntp 6 Dec 20  2014 /var/log/ntpstats

chown ntp:ntp -R /var/log/ntpstats
