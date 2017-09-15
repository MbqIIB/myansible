
# update docker and nvidia driver
```

docker  rm -f mesos-slave
service docker stop

dpkg  -P docker.io

vim /etc/apt/sources.list
deb http://ftp.unicamp.br/pub/ppc64el/ubuntu/14_04/docker-1.12.6-ppc64el/ trusty main

apt update
apt install docker-engine libltdl7 libsystemd-journal0

docker --version

# driver
dpkg -l | grep nvidia
dpkg -l | grep cuda
apt purge nvidia-352 
apt purge -y ibcuda1-352 
 cd /mnt/shared_fs/
dpkg -i nvidia-driver-local-repo-ubuntu1604_375.66-1_ppc64el.deb
apt update 
apt install nvidia-375*

reboot

mount -a



docker pull ibmcom/flannel-ppc64le:0.5.5
docker tag ibmcom/flannel-ppc64le:0.5.5 powerai-vision-flannel:0.5.5

cd /opt/powerai-vision/bin/
chmod a+x *.sh

vim k8s_worker_start.sh
master_ip=192.168.33.30
worker_ip=192.168.33.91

ROOT_DIR=$(cd `dirname $0`/..; pwd)
K8S_IMAGE=powerai-vision-kubernetes:v1.6.4.2-share


FLANNEL_ENABLED=true ./k8s_worker_start.sh
./k8s_worker_stop.sh

docker ps
cat ../run/flannel/subnet.env
ifconfig docker0
ifconfig docker0 10.0.96.1/24
ifconfig docker0 20.0.41.1/24
ifconfig docker0 20.0.96.1/24

vim /etc/default/docker
DOCKER_OPTS="--bip=20.0.96.1/24 --mtu=1472"


service docker stop
service docker start
docker ps



./kubectl get nodes
NAME            STATUS                     AGE       VERSION
192.168.33.30   Ready,SchedulingDisabled   3h        v1.6.4+$Format:%h$
192.168.33.91   Ready                      2m        v1.6.4+$Format:%h$
192.168.33.92   Ready                      2h        v1.6.4+$Format:%h$
192.168.33.93   Ready,SchedulingDisabled   3h        v1.6.4+$Format:%h$





BIN_DIR=`pwd`
#WORKER=192.168.33.93
#WORKER=192.168.33.92
WORKER=192.168.33.91
$BIN_DIR/kubectl label --overwrite nodes $WORKER "poweraivision/gpu_cluster=yes"
$BIN_DIR/kubectl label --overwrite nodes $WORKER "poweraivision/nongpu_cluster=yes"


./kubectl describe nodes

```
