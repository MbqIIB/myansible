#!/bin/bash
nova flavor-create kvm.small auto 2048 20 1
nova flavor-create kvm.4c8g20G  auto 8192 20 4
nova flavor-create kvm.4c8g50G  auto 8192 50 4
nova flavor-create kvm.4c8g100G  auto 8192 100 4
nova flavor-create kvm.4c8g200G  auto 8192 200 4
nova flavor-create kvm.8c16g200G  auto 16384 200 8

nova flavor-create docker.small  auto 2048 20 1
nova flavor-create docker.4c8g100G  auto 8192 100 4
nova flavor-create docker.4c8g200G  auto 8192 200 4

nova flavor-create docker.6c10g40G auto 10240  40 6
#
#
#
#
#nova flavor-create kvm.4c4g100G  auto 4096 100 4
#nova flavor-create kvm.10c64g100G  auto 65536 100 10
#
#
#nova flavor-create smt4c.1s1c4t20g100G auto  20480 100 4

fp=flavorlist.log
#nova flavor-list > $fp
nova flavor-list --all --extra-specs  > $fp
#set -x
# smt flaovr
CpuNum=4
CPU_THREADS=4
CPU_CORES=1
CPU_SOCKETS=1

#Disk=100
for Disk in 20 100
do
	echo "Disk = $Disk G"

for MemGB in 8 16 20 32 64
do
        fname="smt${CpuNum}c.1s1c${CpuNum}t${MemGB}g${Disk}G"

        grep "${fname}" $fp
        if [ $? == 0 ];then
                #echo "Have $fname"
		continue
        fi

	nova flavor-create ${fname} auto  $((${MemGB}*1024)) ${Disk} ${CpuNum}
        fid=$(nova flavor-list | grep ${fname}| awk -F '|' '{print $2}')
        nova flavor-key ${fid} set hw:cpu_cores=${CPU_CORES} hw:cpu_sockets=${CPU_SOCKETS} hw:cpu_threads=${CPU_THREADS}
        nova flavor-show ${fid}
        sleep 1
done

done

echo " Done "
