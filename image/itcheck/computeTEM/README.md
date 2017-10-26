# install tem
```
ansible management-server -m script -a "autoInstallTem.sh"


ansible 172.16.0.117 -m ping
ansible 172.16.0.117 -m shell -a "hostname"
ansible 172.16.0.117 -m shell -a "hostnamectl set-hostname evaluation-n1"
ansible 172.16.0.117 -m shell -a "hostname"
ansible 172.16.0.117 -m shell -a "ls /var/opt/ "
ansible 172.16.0.117 -m script -a "autoInstallTem.sh"

ansible 172.16.0.117 -m shell -a "/etc/init.d/besclient stop "

```

# ex
ansible blockchain-compute -m shell "chage -l root"
ansible blockchain-compute -m shell -a "chage -l root"
ansible blockchain-compute -m shell -a "chage -l opuser"
ansible blockchain-compute -m shell -a "chage -m 0 -M 99999 opuser"
ansible blockchain-compute -m shell -a "chage -m 0 -M 99999 qiang"
ansible blockchain-compute -m shell -a "chage -l qiang"

ansible management-server -m shell -a "chage -l hightall"
ansible management-server -m shell -a "chage -m 0 -M 99999 hightall"
ansible management-server -m shell -a "chage -l hightall"
ansible management-server -m shell -a "chage -l root"
ansible management-server -m shell -a "chage -m 0 -M 99999 root"
ansible management-server -m shell -a "chage -l root"

