openssl passwd -1 -salt 'super' 'passw0rd'
$1$super$440quZi/kSzmHnTJR1j3a.

wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/ppc64el/cuda-repo-ubuntu1604_8.0.61-1_ppc64el.deb

`sudo dpkg -i cuda-repo-ubuntu1604_8.0.61-1_ppc64el.deb`
`sudo apt-get update`
`sudo apt-get install cuda`


wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/ppc64el/cuda-repo-ubuntu1604_8.0.61-1_ppc64el.deb
    4  `sudo dpkg -i cuda-repo-ubuntu1604_8.0.61-1_ppc64el.deb`
    5  `sudo apt-get update`
    6  `sudo apt-get install cuda`
    7  dpkg -i cuda-repo-ubuntu1604_8.0.61-1_ppc64el.deb
    8  sudo apt-get install cuda
    9  nvidia-smi 
   10  exit
   11  ls




root@fnode6-7:~# docker pull ppc64le/ubuntu
root@fnode6-7:~# docker pull ppc64le/ubuntu:16.04
