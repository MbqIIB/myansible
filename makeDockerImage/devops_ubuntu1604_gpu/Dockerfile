FROM ppc64le/ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y  apt-utils
RUN apt-get install -y  iputils-ping
RUN apt-get install -y  initramfs-tools
RUN apt-get install -y  linux-libc-dev gcc openssh-server sudo net-tools vim python3
RUN apt-get install -y  software-properties-common python3-software-properties libudev1 libudev-dev sg3-utils pciutils
RUN apt-get install -fy make cscope ctags doxygen git
#RUN wget ftp://ftp.unicamp.br/pub/linuxpatch/toolchain/at/ubuntu/dists/precise/6976a827.gpg.key ; apt-key add 6976a827.gpg.key ; rm 6976a827.gpg.key
#RUN add-apt-repository "deb ftp://ftp.unicamp.br/pub/linuxpatch/toolchain/at/ubuntu trusty at10.0 "
#RUN apt-get -y update
#RUN apt-get -y install advance-toolchain-at10.0-runtime advance-toolchain-at10.0-perf advance-toolchain-at10.0-devel advance-toolchain-at10.0-mcore-libs

# install shellinabox
RUN apt install -y shellinabox
RUN sed -i '/^exit 0$/i\/usr\/bin\/shellinaboxd  -b -t' /etc/rc.local

# install cuda
RUN wget -q http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/ppc64el/7fa2af80.pub ; apt-key add 7fa2af80.pub  ; rm 7fa2af80.pub
RUN add-apt-repository  -u "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/ppc64el /"
#RUN apt install -y nvidia-* nvidia-361-dev nvidia-361-uvm
#RUN rm /var/lib/dpkg/info/nvidia-361.postinst
RUN apt install 
RUN apt-get install -y cuda


ADD . /bd_build
#RUN mkdir /opt/RunOnce
#RUN cp -r /bd_build/bin/FlashGT /opt/RunOnce/

RUN apt install -y locales
RUN sudo locale-gen 'en_US.UTF-8'
RUN echo 'LC_ALL=en_US.UTF-8' >> /etc/environment 
RUN echo 'LANG=en_US.UTF-8' >> /etc/environment 

RUN sed -i 's/^PermitRootLogin.\+$/PermitRootLogin no/g' /etc/ssh/sshd_config
RUN usermod -p '$1$super$440quZi/kSzmHnTJR1j3a.' root

RUN useradd -m -p '$1$super$uXdjVfWjBYtxOPjOXZb3k0' -s /bin/bash opuser
RUN usermod -aG sudo opuser
RUN sed -i 's/^SSHD_OPTS=$/SSHD_OPTS=-u0/' /etc/default/ssh
RUN sed -i 's/^exit 0$/service ssh start\nexit 0/' /etc/rc.local
RUN chage -d 0 root
RUN chage -m 1 root
RUN chage -M 90 root
RUN chage -W 7 root 
RUN chage -d 0 opuser
RUN chage -m 1 opuser
RUN chage -M 90 opuser
RUN chage -W 7 opuser

RUN  /bd_build/update.sh

CMD ["/sbin/my_init"]
