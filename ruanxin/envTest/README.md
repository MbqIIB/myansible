
# log
```
| b2e7ac94-b7b1-4617-8810-ae5586262ee1 | linzhbj-testing--kvm2c4g20G-20170703_102047n00024 | ACTIVE | -          | Running     | priv_net1=30.30.3.150 |
Create b2e7ac94-b7b1-4617-8810-ae5586262ee1 Active
ERROR (Forbidden): Quota exceeded for cores, ram: Requested 2, 4096, but already used 250, 512000 of 250, 512000 cores, ram (HTTP 403) (Request-ID: req-d47bf86b-ce4e-4c1d-bd16-9218c206da45)


| 3e4f924f-928c-4324-bbe0-c2abff6b0951 | linzhbj-testing--kvm2c4g20G-20170703_105820n00008 | ACTIVE | -          | Running     | priv_net1=30.30.3.160 |
Create 3e4f924f-928c-4324-bbe0-c2abff6b0951 Active
ERROR (Forbidden): Quota exceeded for cores, instances: Requested 2, 1, but already used 20, 10 of 20, 10 cores, instances (HTTP 403) (Request-ID: req-48698d4a-ca31-4dbe-a0b2-9f5ac74ffb43)
```


# test env
## config hosts
```
[ping-test]
svx3_n1 ansible_host=10.111.25.206 ansible_user=opuser ansible_become=true ansible_become_pass=zaq123wsx
svx2_n1 ansible_host=10.111.25.207 ansible_user=opuser ansible_become=true ansible_become_pass=zaq123wsx
svx3_n2 ansible_host=10.111.25.209 ansible_user=opuser ansible_become=true ansible_become_pass=zaq123wsx

ansible all -i hosts -m ping
ansible-playbook -i hosts iperf_u.yml

```
## ping test
```
| 83b434fe-b349-43a4-ac50-b7e4f7aa2431 | linzhbj-testing--kvm4c8g20G-20170704_093924n00000_svx3 | ACTIVE | -          | Running     | priv_net1=30.30.5.18, 10.111.25.206 |
| 9706fc46-ade1-4050-b3d2-5e26f41693b7 | linzhbj-testing--kvm4c8g20G-20170704_093924n00001_svx2 | ACTIVE | -          | Running     | priv_net1=30.30.5.19, 10.111.25.207 |
| 05e18ddc-a0cc-44ed-ad19-11143d2191f0 | linzhbj-testing--kvm4c8g20G-20170704_093924n00002_svx1 | ACTIVE | -          | Running     | priv_net1=30.30.5.20, 10.111.25.208 |
| d2469f95-6254-4303-b1c7-92bcbadbd4ac | linzhbj-testing--kvm4c8g20G-20170704_093924n00003_svx3 | ACTIVE | -          | Running     | priv_net1=30.30.5.21, 10.111.25.209 |

kvm svx3 to svx2
ping  -q -w 300 -D -c 10000 10.111.25.207 >> tosvx2floating_ping.log
ping  -q -w 300 -D -c 10000 30.30.5.19 >> tosvx2internal_ping.log

kvm svx3 to svx3
ping  -q -w 300 -D -c 10000 10.111.25.209 >> tosvx3floating_ping.log
ping  -q -w 300 -D -c 10000 30.30.5.21 >> tosvx3internal_ping.log


ssh gw ,  cd /home/test
ping  -q -w 300 -D -c 10000 10.111.25.207 >> gwtosvx2floating_ping.log
ping  -q -w 300 -D -c 10000 10.111.25.209 >> gwtosvx3floating_ping.log
```

## iperf
```
nova secgroup-add-rule default tcp 5001 5001 0.0.0.0/0
svx2
iperf -s

svx3 to svx2
iperf -c 30.30.5.19 -t 30     -w 400k  >> perftosvx2internal_ping.log
iperf -c 10.111.25.207 -t 30  -w 400k  >> perftosvx2floating_ping.log

svx3 to svx3
iperf -c 30.30.5.21 -t 30     -w 400k  >> perftosvx3internal_ping.log
iperf -c 10.111.25.209 -t 30  -w 400k  >> perftosvx3floating_ping.log

gw to kvm
iperf -c 10.111.25.207 -t 30  -w 400k  >> gwperftosvx2floating_ping.log
iperf -c 10.111.25.209 -t 30  -w 400k  >> gwperftosvx3floating_ping.log



dd if=/dev/zero of=./iotest.2 oflag='direct' bs=1M count=1024
dd if=/dev/zero of=./iotest.2 oflag='dsync' bs=1M count=1024
