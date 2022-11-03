#!/bin/bash

# Check root
if [ $(id -u) -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

# Update to latest
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt clean
apt autoremove

#  Install the qemu gueast agent used by Proxmox
apt install qemu-guest-agent -y

# Reset the VM to make it ready as a template
truncate -s 0 /etc/machine-id 
cloud-init clean
