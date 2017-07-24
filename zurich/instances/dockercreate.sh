
#!/bin/bash
set -x

DOCKER_FLAG="-idt"
#DOCKER_PRIV="--privileged=true"
DOCKER_DEVICES="--device /dev/nvidia0:/dev/nvidia0 --device /dev/nvidiactl:/dev/nvidiactl --device /dev/nvidia-uvm:/dev/nvidia-uvm"
#DOCKER_DEVICES="--device /dev/nvidia1:/dev/nvidia1 --device /dev/nvidiactl:/dev/nvidiactl --device /dev/nvidia-uvm:/dev/nvidia-uvm"
#DOCKER_DEVICES="--device /dev/nvidia0:/dev/nvidia0 --device /dev/nvidia1:/dev/nvidia1 --device /dev/nvidiactl:/dev/nvidiactl --device /dev/nvidia-uvm:/dev/nvidia-uvm"


DOCKER_DNS="--dns 9.4.4.238 --dns 9.4.9.235 --dns 9.4.8.97 --dns-search zurich.ibm.com"

DOCKER_NAME="--name lin_ubuntu_16_v1"

#DOCKER_NET="--net host"
#DOCKER_PORT="-p 5000:5001"


#DOCKER_IMAGE="ubuntu1604_ppc64le_v1"
DOCKER_IMAGE="nova-8b843ae5-f775-4599-8acd-874163e88e56"
#DOCKER_COMMAND="/opinit"
DOCKER_COMMAND="/sbin/my_init"
docker run $DOCKER_FLAG $DOCKER_PRIV $DOCKER_DEVICES $DOCKER_NET $DOCKER_DISK $DOCKER_DNS $DOCKER_NAME $DOCKER_PORT $DOCKER_IMAGE $DOCKER_COMMAND

