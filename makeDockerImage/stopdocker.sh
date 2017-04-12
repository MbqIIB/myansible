#!/bin/bash

dlist=$(awk -F ' ' '{print $1}' dockeract)

for id  in ${dlist[@]}
do

	echo "$id"

done
