#!/bin/bash

# Check root
if [ $(id -u) -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

IP="$1"
CIDR_IP="$IP/24"
CONFIG_FILE="/etc/netplan/00-installer-config.yaml"

# Check if IP is set
if [ -z "$IP" ]; then
  echo "Please provide an IP address as first argument"
  exit 1
else
  echo "STATIC_CIDR_IP: $CIDR_IP"
fi

CURRENT_CIDR_IP=$(ip a | grep -oP "([0-9]+\.){3}[0-9]+\/24")
echo "CURRENT_CIDR_IP: $CURRENT_CIDR_IP"

DEFAULT_GATEWAY=$(ip route | grep default | awk -- '{printf $3}')
echo "DEFAULT_GATEWAY: $DEFAULT_GATEWAY"

DEFAULT_NIC=$(ip route | grep default | awk -- '{printf $5}')
echo "DEFAUL_NIC: $DEFAULT_NIC"

cat > $CONFIG_FILE <<EOF
# This is the network config altered by 'lasse'
network:
  version: 2
  renderer: networkd
  ethernets:
    $DEFAULT_NIC:
      dhcp4: no
      addresses:
        - $CIDR_IP
      routes:
        - to: default
          via: $DEFAULT_GATEWAY
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
EOF

netplan apply
