#!/bin/bash

disk() {
	df -h
}





utime() {
	uptime
}





returny() {
	return $(( 2 + 10 ))
}











disk
utime
returny 
echo $?
