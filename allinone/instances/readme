


openstack network list

export NET_ID=$(openstack network list | awk '/ provider / { print $2 }')

openstack stack create -t demo-template.yml --parameter "NetID=$NET_ID" stack
