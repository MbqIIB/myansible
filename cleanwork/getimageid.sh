#!/bin/bash

IMAGELIST=allimage.log.saving

#cat ${IMAGELIST} | sort -k 8  | awk -F '|' '{print $5}' | uniq  -c 
cat ${IMAGELIST} | sort -k 8  | awk -F '|' '{print $5}' | uniq  -c |  sort -nr    | grep -v " 1 " | awk -F ' ' '{print $2}'  > ${IMAGELIST}.more1

