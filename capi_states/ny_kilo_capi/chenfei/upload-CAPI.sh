#!/bin/bash

# command NAME FILE_NAME

out=`glance image-create --name=$1 --is-public=true --disk-format=ops --container-format=bare --file $2`
id=`echo "$out" | grep '^| id' | awk '{print $4}'`
if [ ${#id} != 36 ]; then
	echo "Upload fail."
	exit 1
fi

glance image-update --property acc_name=$1 --property acc_type=capi --property accelerator_type=none --property chip_sn=ku060 --property chip_vendor=Xilinx --property fpga_board=Alphadata --property image_type=accelerator $id

exit $?
