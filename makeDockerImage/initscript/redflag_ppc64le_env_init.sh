#!/bin/bash

#set -x

echo "Run image clean work ......"

#clean user
function userclean()
{
	userdel -r mrhines
	userdel -r crluser
	userdel -r shil
}

#set default password
function setdefpass()
{
#disable ssh root login
sed -i "s/^PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config

#root passw0rd
#root:$1$QC9f0wJn$ejSVJfwLgdnWHQMrZrKGO1:16611:1:90:7:::
ROOTPASS="\$6\$tZIWhKGn\$ZLhQd5HqCik59sX\/seUlIuGnrXVAUuN\/e.4Z2b5Rd.0UVQMjRtE9eUmHEuY0Fx3Q1WFspxTvGJkVgg1I\/se5k1"
sed -i "s/^root.\+:::/root:${ROOTPASS}:16604:1:90:7:::/" /etc/shadow

#opuser p0weruser
#opuser:$1$J...EHZi$4TF56dpruMMvAr47ZdtmH0:16611:1:90:7:::
OPUSERPASS="\$6\$qmnx9n4n\$d.PR1XEimOPml1afax5Q6BfrZO6XSH5w6y2Djy5wPRA.dygzFju.BDqRIQ4YnC3ieg5CQJdtKj\/2f0SaFs2zB\/"
sed -i "s/^opuser.\+:::/opuser:${OPUSERPASS}:16604:1:90:7:::/" /etc/shadow

chage -l opuser
chage -l root
# must changed password first access
#chage -d 0 opuser
#chage -d 0 root

faillog -r -a
sed -i 's/deny=5/deny=1000/g' /etc/pam.d/*
#sed -i 's/deny=5/deny=1000/g' /etc/pam.d/login
#sed -i 's/deny=5/deny=1000/g' /etc/pam.d/common-auth
#sed -i 's/deny=5/deny=1000/g' /etc/pam.d/other
grep -rn "deny=" /etc/pam.d/

}

# yum set
function yumclean()
{
	yum clean all
	mkdir -p /etc/yum.repos.d/tmp
	#mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/tmp
	#mv /etc/yum.repos.d/tmp/rhel7*.repo /etc/yum.repos.d/
	rm -rf /var/cache/yum/ppc64le/\$releasever/*
}

function cmdhistoryclean()
{
#clean root
history -c
history -w
#clean opuser
> /home/opuser/.bash_history
> /home/opuser/.ssh/known_hosts
> /root/.bash_history
> /root/.ssh/known_hosts
}

function tmpclean()
{
	rm -rf /tmp/yum_save*
}

function main()
{
	userclean
	setdefpass
	yumclean
	tmpclean
	cmdhistoryclean
}

# start here
main


#sed -i "/rhel7_env_init.sh/d" /etc/rc.local
#sed -i "/rhel7_env_init.sh/d" /etc/rc.d/rc.local
rundir=$(pwd)
#echo ${rundir} > /tmp/rundir.log
#cat  ${rundir}/rhel7_env_init.sh >> /tmp/rundir.log
#rm -f ${rundir}/rhel7_env_init.sh
exit 0
