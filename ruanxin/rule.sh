#!/bin/bash




set -x

tenantid=bb5f92980da54ca2903a07c27808a8f6


oldinfo=$(neutron security-group-list --tenant-id  ${tenantid})
echo "${oldinfo}"
defaultid=$( echo "${oldinfo}" | grep " default " | awk -F ' ' '{print $2}')

neutron security-group-rule-list --tenant-id ${tenantid}

neutron security-group-rule-create --tenant-id ${tenantid} \
		--direction egress \
		${defaultid}


neutron security-group-rule-create --tenant-id ${tenantid} \
		--direction ingress \
		--remote-group-id  ${defaultid} \
		${defaultid}
