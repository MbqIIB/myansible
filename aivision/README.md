
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


# paris
dpkg -i aivision_1.0.0_ppc64el.deb


# should build  or import image
/opt/aivision/bin

# import image
sudo docker load -i aivision-etcd_v3.1.5.tar.gz
sudo docker load -i aivision-dnn-cpu_1.0.tar.gz
sudo docker load -i aivision-dnn_1.0.tar.gz
sudo docker load -i aivision-frcnn_1.0.tar.gz
sudo docker load -i aivision-kubernetes_v1.6.1.tar.gz
sudo docker load -i aivision-mongodb_1.0.tar.gz
sudo docker load -i aivision-portal_1.0.tar.gz
sudo docker load -i aivision-preprocessing_1.0.tar.gz
sudo docker load -i aivision-taskanaly_1.0.tar.gz

# copy dataset

```
cp data/* /opt/aivision/data/
```

# start service
sudo ./aivision_start.sh
