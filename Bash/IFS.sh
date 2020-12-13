#!/bin/bash

file="BasicText.txt"

#IFS_OLD=$IFS
#IFS=$'\n'

for item in $(cat $file); do
	echo $item
done
