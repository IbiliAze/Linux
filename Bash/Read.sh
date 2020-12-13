#!/bin/bash



echo -n "What region are you based in? "
read region
echo "You line in $region"
echo
echo





read -p "What city are you based in? " city
echo "You line in $city"
echo
echo





read -p "Enter your name and surname: " name surname
echo "Hello $name $surname"
echo
echo





read -t 5.1 -p "Say something before it's too late: " something
case "$something" in
	something) echo "good timing";;
	*) echo "too late";;
esac
echo
echo





read -n1 -p "Yes or No: " confirm
case "$confirm" in
	Y | y) echo
		echo yes;;
	N | n) echo
		echo no;;
	*) echo
		echo "invalid option";;
esac
echo
echo





read -s -p "Whats your password: " password
	md5sum <<<$password
echo
echo






