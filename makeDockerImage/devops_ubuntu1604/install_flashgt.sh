#!/bin/bash

set -e
source /bd_build/buildconfig
set -x

cd /bd_build/bin/FlashGT
echo "Y Y" | ./cflash_configure


history -c
