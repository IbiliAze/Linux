#!/bin/bash


until [[ -z "$1" ]]; do
	case "$1" in 
		"-x") echo "-x option: VERIFIED";;
		"-y") echo "-y option: VERIFIED";;
		"-z") echo "-z option: VERIFIED";;
		"--") shift
			break ;;
		*) echo "$1 option: NOT FOUND";;
	esac
	shift
done
