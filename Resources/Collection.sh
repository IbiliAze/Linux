#!/bin/bash



[ collectd ]

apt install -y collectd
systemctl start collectd
apt install -y lighttpd git php php-cgi


