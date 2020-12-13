#!/bin/bash



[ auditctl ]

sudo yum install -y audit



cd /etc/audit #view audit settings
less /var/log/audit/audit.log #view audit log messages
