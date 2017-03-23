      8  2017-03-14 22:05:07 dpkg -i cuda-repo-ubuntu1404_7.5-18_ppc64el.deb 
    9  2017-03-14 22:05:18 apt-get update
   10  2017-03-14 22:05:46 apt-cache search cuda
   11  2017-03-14 22:06:13 apt-cache search nvidia
   12  2017-03-14 22:06:38 apt-get install nvidia-352*
   13  2017-03-14 22:08:18 ll /dev | grep nvidia
   14  2017-03-14 22:08:47 nvidia-smi
   15  2017-03-14 22:10:10 exit
   16  2017-03-14 22:12:14 cd /home/opuser/
   17  2017-03-14 22:12:24 ls
   18  2017-03-14 22:12:30 cd cuda_75_ppc64le/
   19  2017-03-14 22:12:31 ls
   20  2017-03-14 22:12:36 chmod +x *
   21  2017-03-14 22:12:38 ls
   22  2017-03-14 22:12:43 ./bandwidthTest 
   23  2017-03-14 22:13:08 ./deviceQuery 
   24  2017-03-14 22:13:22 ./matrixMul 
   25  2017-03-14 22:13:39 ./simpleMultiGPU 
   26  2017-03-14 22:13:56 apt-get install cuda
   27  2017-03-14 22:17:44 nvidia-smi
   28  2017-03-14 22:17:51 ls
   29  2017-03-14 22:19:09 ./bandwidthTest 
   30  2017-03-14 22:19:18 ./deviceQuery 
   31  2017-03-14 22:19:39 ls
   32  2017-03-14 22:19:42 ./matrixMul 
   33  2017-03-14 22:19:54 ./simpleMultiGPU 
   34  2017-03-14 22:20:11 exit
   35  2017-03-14 23:03:11 ls
   36  2017-03-14 23:03:13 history 
   37  2017-03-14 23:03:25 nvidia-smi 
   38  2017-03-14 23:03:36 lspci 
   39  2017-03-14 23:03:40 ls
   40  2017-03-14 23:22:58 exit
   41  2017-03-15 01:54:07 history 
   42  2017-03-15 01:54:35 lsb_release  -a
   43  2017-03-15 01:54:40 uname  -a
   44  2017-03-15 02:09:02 nvidia-smi 
   45  2017-03-15 02:33:34 ls
   46  2017-03-15 02:33:36 apt update
   47  2017-03-15 02:34:02 apt list ---upgradels
   48  2017-03-15 02:34:03 apt list ---upgradel
   49  2017-03-15 02:34:05 apt list ---upgrade
   50  2017-03-15 02:34:10 apt upgrade
   51  2017-03-15 02:34:25 nvidia-smi 
   52  2017-03-15 02:34:32 lscpu 
   53  2017-03-15 02:34:52 apt upgrade
   54  2017-03-15 02:49:28 lsb_release  -a
   55  2017-03-15 02:49:38 uname  -a
   56  2017-03-15 02:49:40 exit
   57  2017-03-15 02:49:45 ls
   58  2017-03-15 02:49:49 apt clean all
   59  2017-03-15 02:49:51 apt clean
   60  2017-03-15 02:49:55 apt-get clean
   61  2017-03-15 02:49:56 ls
   62  2017-03-15 02:50:00 df -h
   63  2017-03-15 02:50:01 ls
   64  2017-03-15 02:50:04 nvidia-smi 
   65  2017-03-15 02:50:07 ls
   66  2017-03-15 02:51:39 sed -i 's/^PermitRootLogin.\+$/PermitRootLogin no/g' /etc/ssh/sshd_config
   67  2017-03-15 02:51:39 usermod -p '$1$super$440quZi/kSzmHnTJR1j3a.' root
   68  2017-03-15 02:51:39 useradd -m -p '$1$super$uXdjVfWjBYtxOPjOXZb3k0' -s /bin/bash opuser
   69  2017-03-15 02:51:39 usermod -aG sudo opuser
   70  2017-03-15 02:52:15 cat /etc/shadow
   71  2017-03-15 02:52:26 useradd -p '$1$super$uXdjVfWjBYtxOPjOXZb3k0' opuser
   72  2017-03-15 02:52:33 usermod -p '$1$super$uXdjVfWjBYtxOPjOXZb3k0' opuser
   73  2017-03-15 02:52:45 useradd  -help
   74  2017-03-15 02:53:01 ls
   75  2017-03-15 02:53:04 cat /etc/shadow
   76  2017-03-15 02:53:05 ls
   77  2017-03-15 02:53:12 history 

   1  ls
    2  su -
    3  sudo su
    4  sudo
    5  lspci
    6  nvidia-smi
    7  ls
    8  uname -a
    9  wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/ppc64el/cuda-repo-ubuntu1404_7.5-18_ppc64el.deb
   10  ls
   11  sudo dpkg -i cuda-repo-ubuntu1404_7.5-18_ppc64el.deb 
   12  apt-get install sudo
   13  su - root
   14  apt-get install sudo
   15  sudo su -
   16  su - root
   17  exit
   18  su - root
   19  exit
   20  s
   21  history 
   22  su - root
   23  exit
   24  su - root
   25  history 



    1  2017-03-15 03:46:34 history -w
    2  2017-03-15 03:46:34 history -w
    3  2017-03-15 03:46:35 exit
    4  2017-03-15 03:46:55 apt clean all
    5  2017-03-15 03:47:01 apt-get clean
    6  2017-03-15 03:47:02 exit
    7  2017-03-15 03:51:29 ls
    8  2017-03-15 03:52:07 wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/ppc64el/cuda-repo-ubuntu1404_7.5-18_ppc64el.deb
    9  2017-03-15 03:52:14 vim /etc/apt/sources.list
   10  2017-03-15 03:52:29 ls
   11  2017-03-15 03:52:32 dpkg -i cuda-repo-ubuntu1404_7.5-18_ppc64el.deb 
   12  2017-03-15 03:52:34 ls
   13  2017-03-15 03:52:44 vim /etc/apt/sources.list.d/cuda.list 
   14  2017-03-15 03:52:56 lspci 
   15  2017-03-15 03:53:04 apt update
   16  2017-03-15 03:53:17 apt install cuda
   17  2017-03-15 03:59:23 nvidia-smi 

apt-get install system-storage-manager
ssm list

cat /etc/apt/sources.list.d/cuda.list 
deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/ppc64el /


https://developer.nvidia.com/cuda-downloads

https://developer.nvidia.com/cuda-75-downloads-archive

wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/ppc64el/cuda-repo-ubuntu1604_8.0.61-1_ppc64el.deb
sudo dpkg -i cuda-repo-ubuntu1604_8.0.61-1_ppc64el.deb
sudo apt-get update
sudo apt-get install cuda



glance image-update d4ab56be-8d53-4c6e-8627-e216f16e6b94 --property accelerator_type=gpu_pcie --property image_type=image --visibility public




# ubuntu 16.04 install cuda
wget http://us.download.nvidia.com/Ubuntu/352.93/NVIDIA-Linux-ppc64le-352.93.run
sh ./NVIDIA-Linux-ppc64le-352.93.run
可能需要重启，用nvidia-smi测试，如果不报错就不用重启
apt-get install nvidia-cuda-toolkit
                                     






