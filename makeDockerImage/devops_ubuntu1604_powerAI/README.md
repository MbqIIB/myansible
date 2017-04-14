## create docker
```shell
openssl passwd -1 -salt 'super' 'passw0rd'
$1$super$440quZi/kSzmHnTJR1j3a.

wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/ppc64el/cuda-repo-ubuntu1604_8.0.61-1_ppc64el.deb
sudo dpkg -i cuda-repo-ubuntu1604_8.0.61-1_ppc64el.deb
sudo apt-get update
sudo apt-get install cuda
nvidia-smi 
```



#### Update base image
```shell
docker pull ppc64le/ubuntu
docker pull ppc64le/ubuntu:16.04
```
