#!/bin/bash



set -- $(getopt x:yz "$0")

until [[ -z "$1" ]]; do
	case "$1" in 
		"-x") value1="$2"
		      date $value1
		      shift;;
		"-y") "-y verified";;
		"-z") "-y verified";;
		"--") shift
			break ;;
		*) "$1 not found"
	esac
done
