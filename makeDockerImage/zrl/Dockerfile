FROM ppc64le/ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y  apt-utils
RUN apt-get install -y  linux-libc-dev gcc openssh-server net-tools vim python3
RUN apt-get install -y  software-properties-common python3-software-properties libudev1 libudev-dev sg3-utils pciutils
RUN apt-get install -fy make cscope ctags doxygen git
RUN wget ftp://ftp.unicamp.br/pub/linuxpatch/toolchain/at/ubuntu/dists/precise/6976a827.gpg.key ; apt-key add 6976a827.gpg.key ; rm 6976a827.gpg.key
RUN add-apt-repository "deb ftp://ftp.unicamp.br/pub/linuxpatch/toolchain/at/ubuntu trusty at10.0 "
RUN apt-get -y update
RUN apt-get -y install advance-toolchain-at10.0-runtime advance-toolchain-at10.0-perf advance-toolchain-at10.0-devel advance-toolchain-at10.0-mcore-libs


ADD . /bd_build
RUN mkdir /opt/RunOnce
RUN cp -r /bd_build/bin/FlashGT /opt/RunOnce/

RUN useradd -m -p '$1$super$uXdjVfWjBYtxOPjOXZb3k0' -s /bin/bash opuser
RUN usermod -aG sudo opuser
RUN sed -i 's/^SSHD_OPTS=$/SSHD_OPTS=-u0/' /etc/default/ssh
RUN sed -i 's/^exit 0$/service ssh start\nexit 0/' /etc/rc.local

RUN  /bd_build/update.sh

CMD ["/sbin/my_init"]
