#!/bin/bash


var1=1
while [ -n "$1" ]; do
	echo "Parameter position number 1 now equals $1"
	echo $var1
	var1=$(( $var1 + 1 ))
	shift
done
