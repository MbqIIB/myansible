
if [ -f $1 ]; then
	if [ -z "$2" ]; then
		echo "Assign a name for this image"
		exit 1
	fi
	if [ -z "$3" ]; then
		echo "Assign a OS type for this image"
		exit 1
	fi
	echo Uploading file $1
	glance image-create --name=$2 \
                           --is-public=true \
                           --property accelerator_type=none  \
                           --property architecture=ppc64le  \
                           --property hw_disk_bus=virtio \
                           --property hw_video_model=vga  \
                           --property hypervisor_type=docker  \
                           --property os_type="$3" \
                           --container-format=docker \
                           --property image_type=image \
                           --property sys_type=ubuntu \
                           --property webshell=true \
                           --disk-format=raw \
                           --file $1
else
	echo "Please choose an image file."
fi

exit

