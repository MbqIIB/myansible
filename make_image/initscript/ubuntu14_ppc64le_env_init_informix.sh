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
sed -i "s/^PrintMotd yes/PrintMotd no/g" /etc/ssh/sshd_config
sed -i "s/^UsePAM no/UsePAM yes/g" /etc/ssh/sshd_config

#root passw0rd
#root:$1$QC9f0wJn$ejSVJfwLgdnWHQMrZrKGO1:16611:1:90:7:::
ROOTPASS="\$6\$tZIWhKGn\$ZLhQd5HqCik59sX\/seUlIuGnrXVAUuN\/e.4Z2b5Rd.0UVQMjRtE9eUmHEuY0Fx3Q1WFspxTvGJkVgg1I\/se5k1"
sed -i "s/^root.\+:::/root:${ROOTPASS}:16604:1:90:7:::/" /etc/shadow

#opuser p0weruser
#opuser:$1$J...EHZi$4TF56dpruMMvAr47ZdtmH0:16611:1:90:7:::
OPUSERPASS="\$6\$qmnx9n4n\$d.PR1XEimOPml1afax5Q6BfrZO6XSH5w6y2Djy5wPRA.dygzFju.BDqRIQ4YnC3ieg5CQJdtKj\/2f0SaFs2zB\/"
sed -i "s/^opuser.\+:::/opuser:${OPUSERPASS}:16604:1:90:7:::/" /etc/shadow

#informix p0weruser
#informix:$1$yuWEfQ4l$1OPB2.Fgg2pt48Z4H4HPp0:16611:1:90:7:::
OPUSERPASS="\$1\$yuWEfQ4l\$1OPB2.Fgg2pt48Z4H4HPp0"
sed -i "s/^informix.\+:::/informix:${OPUSERPASS}:16604:1:90:7:::/" /etc/shadow


chage -l opuser
chage -l informix
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

# for ssh
#sed  -i 's/^@include common-password/#@include common-password/g'  /etc/pam.d/login
#sed  -i 's/^@include common-password/#@include common-password/g'  /etc/pam.d/passwd
#sed -i 's/^password \+ required \+ pam_passwdqc.so min=disabled,8,8,8,8 passphrase=0 random=0 enforce=everyone/#password    required    pam_passwdqc.so min=disabled,8,8,8,8 passphrase=0 random=0 enforce=everyone/g' /etc/pam.d/login
#sed -i 's/^password \+ required \+ pam_passwdqc.so min=disabled,8,8,8,8 passphrase=0 random=0 enforce=everyone/#password    required    pam_passwdqc.so min=disabled,8,8,8,8 passphrase=0 random=0 enforce=everyone/g' /etc/pam.d/passwd

}

# aptget set
function aptgetclean()
{
	apt-get clean all
	#/var/cache/apt/archives/
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
> /home/informix/.bash_history
> /home/informix/.ssh/known_hosts
rm -rf /home/informix/.bash_history
rm -rf /root/.bash_history
rm -rf /home/opuser/.bash_history
}

function tmpclean()
{
	rm -rf /tmp/yum_save*
}

function main()
{
	userclean
	setdefpass
	aptgetclean
	#tmpclean
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
