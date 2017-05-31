FROM ppc64le/centos:7

RUN yum update -y
RUN yum -y update; yum clean all
RUN yum -y install openssh-server passwd; yum clean all
RUN mkdir /var/run/sshd
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''

RUN yum install -y  net-tools vim  tree telnet openssh
RUN yum install -y  gcc make

RUN yum install -y  epel-release;yum clean all
RUN yum update -y  epel-release;yum clean all
RUN yum install -y  shellinabox;yum clean all

ADD ./rc.local /etc/rc.d/
ADD ./opinit /

RUN echo 'LC_ALL=en_US.UTF-8' >> /etc/environment 
RUN echo 'LANG=en_US.UTF-8' >> /etc/environment 

RUN sed -i 's/^#PermitRootLogin.\+$/PermitRootLogin no/g' /etc/ssh/sshd_config
RUN usermod -p '$1$super$440quZi/kSzmHnTJR1j3a.' root

RUN useradd -m -p '$1$super$uXdjVfWjBYtxOPjOXZb3k0' -s /bin/bash opuser

RUN chage -d 0 root
RUN chage -m 1 root
RUN chage -M 90 root
RUN chage -W 7 root
RUN chage -d 0 opuser
RUN chage -m 1 opuser
RUN chage -M 90 opuser
RUN chage -W 7 opuser

CMD ["/opinit"]
