#!/bin/bash

# root
sed -i 's/^PermitRootLogin.\+$/PermitRootLogin no/g' /etc/ssh/sshd_config
usermod -p '$1$super$440quZi/kSzmHnTJR1j3a.' root

# opuser
useradd -m -p '$1$super$uXdjVfWjBYtxOPjOXZb3k0' -s /bin/bash opuser
usermod -aG sudo opuser

# boot ssh service
sed -i 's/^SSHD_OPTS=$/SSHD_OPTS=-u0/' /etc/default/ssh
sed -i '/^exit 0$/ i\service ssh start' /etc/rc.local


chage -d 0 root
chage -m 1 root
chage -M 90 root
chage -W 7 root 
chage -d 0 opuser
chage -m 1 opuser
chage -M 90 opuser
chage -W 7 opuser

