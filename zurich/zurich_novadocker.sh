#!/bin/bash

insdir=/home/installdir
mkdir ${insdir}
scp root@ansible:/root/myansible/containerplus20160729.tar.gz ${insdir}
scp root@ansible:/root/myansible/IaaS-nova-docker20160729.tar.gz ${insdir}

pip install -U pip
pip uninstall setuptools
pip install 'setuptools<20.2'

pushd ${insdir}
tar xvf IaaS-nova-docker20160729.tar.gz
pushd IaaS-nova-docker
pip install .
popd

tar xvf containerplus20160729.tar.gz

pushd containerplus
pip install -r requirements.txt
./start-daemon
popd

popd
