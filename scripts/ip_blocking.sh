#!/bin/bash

# Script to automate blocking of suspicious IPs

# Wazuh API URL and credentials
WAZUH_API="https://your-wazuh-manager:55000"
API_USER="admin"
API_PASS="password"

# IP to block (example)
IP_TO_BLOCK="192.168.1.100"

# Command to add IP to blocklist
curl -u $API_USER:$API_PASS -k -X POST -d "ip=$IP_TO_BLOCK" $WAZUH_API/security/firewall/blocklist

echo "IP $IP_TO_BLOCK blocked on Wazuh firewall"
