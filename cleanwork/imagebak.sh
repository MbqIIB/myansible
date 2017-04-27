#!/bin/bash

set -x

#mount -t nfs 172.16.10.76:/gpfs/gpfs_community/community_openstack /gpfs/gpfs_community/community_openstack
#df 
#sleep 5
pushd /gpfs/gpfs_community/community_openstack
#Key='16-12-28'
#Key='16-12-29'
#Key='16-12-30'
Key='16-12-31'
Key='17-01'

Time=$(date '+%Y%m%d_%H%M%S')
bakdir=imagebak_${Key}_${Time}

mkdir -p ${bakdir}

pushd $bakdir



Gimagelist=gimagelist.${Time}.log
Nimagelist=nimagelist.${Time}.log

glance image-list > $Gimagelist
nova image-list > $Nimagelist


GlanceFile=${Nimagelist}.${Key}.log
grep "| ${Key}" ${Nimagelist}  > $GlanceFile


imagelist=$(awk -F '|' '{print $2}' $GlanceFile )


for id in ${imagelist[@]}
do
    echo ${id}

    glance image-show ${id} | tee image_${id}.log
    sleep 5

    echo "start download ${name}"
    glance image-download \
        --file image_${id} ${id}

    md5sum image_${id} > image_${id}.md5sum

    echo "sleep 10 s"
    sleep 10
done

popd
popd

echo "pushd /gpfs/gpfs_community/community_openstack/${bakdir}"
echo "Finish"
