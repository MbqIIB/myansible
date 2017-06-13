
dpkg -i aivision_1.0.0_ppc64el.deb



 mkdir aivision
root@s822lc:/home/chinalab# dpkg -x aivision_1.0.0_ppc64el.deb aivision


cd /opt/aivision/bin/

wget -O - http://ma1dock1.platformlab.ibm.com/static/trust-me | bash 

/etc/hosts
9.21.49.147 ma1dock1.platformlab.ibm.com



build_image.sh

aivision_setup.sh 
aivision_start.sh
aivision_stop.sh
