


nova list --all-tenants --host svp6 >> shutdownlist.txt
nova list --all-tenants --host svp9 >> shutdownlist.txt
nova list --all-tenants --host svp10 >> shutdownlist.txt
nova list --all-tenants --host svp11 >> shutdownlist.txt
nova list --all-tenants --host svp12 >> shutdownlist.txt

svp6
svp9
svp10
svp11
svp12

cat shutdownlist.txt | awk -F " " '{print $6}'  > tenants.txt
keystone tenant-list > alltenantslist.txt
../getmailbyvmtenant.sh
cat mail.txt | sort |  uniq     > uniq.csv

nova list --all-tenants --status ACTIVE


svf1:/home/linzhbj/openpower/database_bak/database_backup.sh

scp -r svf1:/data/OpenPowerDataBak/DataBak-svf1-2017061* /home/backinfo/




ansible svp9,svp10,svp11,svp12 -m shell -a "docker ps"
ansible svp9,svp10,svp11,svp12 -m shell -a "poweroff"



ansible svp1,svp2 -m shell -a "docker ps"
ansible svf1,svf2 -m shell -a "docker ps"
ansible svf1,svf2 -m shell -a "poweroff"


ansible svx11,svx12,svx13,svx14,svx15,svx16,svx17,svx18  -m shell -a "docker ps"
ansible svx11,svx12,svx13,svx14,svx15,svx16,svx17,svx18  -m shell -a "virsh list --all"
ansible svx11,svx12,svx13,svx14,svx15,svx16,svx17,svx18  -m shell -a "poweroff"



ansible  zabbix -m ping
ansible  zabbix -m shell -a "poweroff"

ansible svx1  -m shell -a "virsh list --all"


