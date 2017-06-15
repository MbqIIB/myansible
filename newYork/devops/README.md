# config compute
``` shell
ansible compute-server -m shell -a "cat /etc/rc.local | grep ifconfig"
ansible brnode13-9 -m shell -a "cat /etc/rc.local | grep ifconfig"

ansible  compute-server-ppc64le-kvm -m shell -a "lscpu"
ansible  compute-server-ppc64le-kvm -m shell -a "cat /etc/rc.local | grep ppc"
ansible  compute-server-ppc64le-docker -m shell -a "cat /etc/rc.local | grep ppc"
ppc64_cpu --smt=off &

ansible-playbook rclocal.yml


ansible  compute-server-ppc64le-kvm -m shell -a "tail -5 /etc/rc.local "
ansible  compute-server-ppc64le-docker -m shell -a "tail -5 /etc/rc.local "



ansible  compute-server-ppc64le-kvm -m shell -a "virsh list --all"
ansible  compute-server-ppc64le-docker -m shell -a "docker ps -a"

ansible  compute-server-ppc64le-docker -m shell -a "poweroff"

ansible  compute-server-ppc64le-kvm -m shell -a "poweroff"

```
