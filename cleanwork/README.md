# clean old instance

cat tenantlist  | awk -F "|" '{print $4}'  > vmtenantlist.txt

keystone tenant-list > alltenantlist.txt

getmail.sh

awk -F " " '{print $4}' mail.txt | wc -l



#image clean
nova image-list > allimagelist
cat allimagelist  | grep "\-15\-"  | grep -v management | grep -v linyh


# clean compute docker images
``` shell
#change key in script

default Key="s-"
ansible compute-server-docker -m script  -a 'cpDockerImagesClean.sh'
```
