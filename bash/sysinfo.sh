#!/bin/bash

# sysinfo.sh
# creating variables to call the command

#variable for FQDN
FQDN=$(hostname -f)

#variable for Operating system
OS=$(hostnamectl| grep System)

#variable for IP Address
IPaddress=$(hostname -i )

#variable for showing Free Space
availableSpace=$(df -h / | awk 'NR==2 {print $4}')

echo Report of $(hostname) 

cat <<EOF
#####################################################
FQDN : $FQDN
$OS
Ip Address :$IPaddress
Root FIlesystem Free Space:$availableSpace
#####################################################
EOF
