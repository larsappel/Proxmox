#!/bin/bash

# Check root
if [ $(id -u) -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

NEW_HOSTNAME=$1

# Check if hostname is set
if [ -z "$NEW_HOSTNAME" ]; then
  echo "Please provide a hostname as first argument"
  exit 1
else
  echo "NEW_HOSTNAME: $NEW_HOSTNAME"
fi

CURRENT_HOSTNAME=$(hostname)
echo "CURRENT_HOSTNAME: $CURRENT_HOSTNAME"

# Find the hostname entry in the host file
CURRENT_HOSTNAME_HOSTFILE=$(cat /etc/hosts | grep 127.0.1.1 | awk -- '{printf $2}')
echo "CURRENT_HOSTNAME_HOSTFILE: $CURRENT_HOSTNAME_HOSTFILE"

sed -i "s/$CURRENT_HOSTNAME_HOSTFILE/$NEW_HOSTNAME/g" /etc/hosts

hostnamectl set-hostname $NEW_HOSTNAME
