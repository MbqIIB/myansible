#!/bin/bash
apt install -y shellinabox  && apt-get clean all
sed -i '/^exit 0$/i\/usr\/bin\/shellinaboxd  -b -t' /etc/rc.local
