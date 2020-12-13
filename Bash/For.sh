#!/bin/bash


for city in Alaska California Paris Baku London York Manchester Glasgow; do
	echo $city
done





for city in 'Alaska' 'California' 'Paris' 'Baku' 'London' 'York' 'Manchester' 'Glasgow'; do
 	echo $city
done





list="Alaska California Paris Baku London York Manchester Glasgow"
for city in list; do
	echo $city
done





for file in /home/$USER/Documents/Git/AWS/*; do
	if [ -d $file ]; then
		echo "$file is a Directory"
	elif [ -f $file ]; then
		echo "$file is a regular File"
	else
		echo "$file is nothing"
	fi
done





for ip in 192.168.0.{1..2}; do
	ping $ip -c 1 -W 0.1 | grep ^"64"
done





for (( i=0; i <=10; i++ )); do
	echo $i
done





counter=0
names=$(cat BasicText.txt)
for item in $names; do
	(( counter++ ))
	if [[ $item == Bananas ]]; then
		echo "We found Banana at position $counter"
		break
	fi
done
