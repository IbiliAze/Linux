#!/bin/bash


if [[ -z "$1" ]]; then
	printf "Usage: \n-d (disk info) \n-p (current process) \n-u (system uptime)\n"
elif [[ -n "$1" ]]; then
	while [[ -n "$1" ]]; do
		case "$1" in
			"-d") echo "Disk info: $(df -h)";;
			"-p") echo "Current process:"; htop;;
			"-u") echo "System uptime: $(uptime)";;
		esac
		shift
	done
fi
