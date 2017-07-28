| 06eb9003-997e-4b4f-af03-3518e8d651bb | management-accdnn-tyan2-smt8c.1s1c8t16g100G-n0 | ACTIVE  | Running     | ent_vlan=192.168.36.133, 172.16.3.254; management=192.168.16.155 |
+--------------------------------------+------------------+--------+------------+-------------+------------------------------------------------------------------+
| ID                                   | Name             | Status | Task State | Power State | Networks                                                         |
+--------------------------------------+------------------+--------+------------+-------------+------------------------------------------------------------------+
| 17923101-9afc-47f2-bd6e-6357aa9b26f6 | accdnnservice-n0 | ACTIVE | -          | Running     | ent_vlan=192.168.36.136, 172.16.0.109; management=192.168.16.157 |
| 0683c443-6e9a-47b0-8101-43071771845b | accdnnservice-n1 | ACTIVE | -          | Running     | ent_vlan=192.168.36.137, 172.16.0.11; management=192.168.16.158  |
| f16834bf-7d3a-435a-a97c-29839dcc6fe1 | accdnnapiservice-n2 | ACTIVE | -          | Running     | ent_vlan=192.168.36.138, 172.16.0.110; management=192.168.16.159 |
+--------------------------------------+------------------+--------+------------+-------------+------------------------------------------------------------------+

ansible -i ansible_hosts all -m ping
ansible -i ansible_hosts all -m shell -a "systemctl status ntp"

ansible-playbook -i ansible_hosts  ../../ntpd/ubuntu_ntpd.yml
ansible-playbook -i ansible_hosts   updatehosts.yml
ansible-playbook -i ansible_hosts  ../bashrc.yml

ansible -i ansible_hosts all -m shell -a "date"
ansible -i ansible_hosts all -m shell -a "history"
