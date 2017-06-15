


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
