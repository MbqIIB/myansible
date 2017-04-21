## Power AI
### create power AI image

```

https://developer.nvidia.com/rdp/cudnn-download
linzhaolover@163.com
850104erji
dpkg -i libcudnn5*deb

https://public.dhe.ibm.com/software/server/POWER/Linux/mldl/ubuntu
wget https://public.dhe.ibm.com/software/server/POWER/Linux/mldl/ubuntu/mldl-repo-local_3.4.1_ppc64el.deb
wget https://public.dhe.ibm.com/software/server/POWER/Linux/mldl/ubuntu/mldl-repo-network_3.4.0_ppc64el.deb
dpkg -i mldl-repo-local*.deb
apt update


sudo apt-get purge mldl-repo-local
sudo dpkg -i mldl-repo-network_3.4.0_ppc64el.deb

```

## test cuda 8
```
export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64 ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
cuda-install-samples-8.0.sh ~
cd ~/NVIDIA_CUDA-8.0_Samples/0_Simple/vectorAdd
make
./vectorAdd
```

## ref
(https://public.dhe.ibm.com/software/server/POWER/Linux/mldl/ubuntu/)[https://public.dhe.ibm.com/software/server/POWER/Linux/mldl/ubuntu]
