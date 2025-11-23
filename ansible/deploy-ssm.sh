#!/bin/bash

# Deploy SSM Agent to Windows instances via RDP
# Usage: ./deploy-ssm.sh [dev1|dev2|sales]

SCRIPT_PATH="/Users/drewstoneburger/repos/opnova/ansible/install-ssm.ps1"

case "$1" in
    "dev1"|"dev-agent01")
        echo "Connect to Dev-Agent01 (13.58.30.31) and run:"
        echo "Copy the PowerShell script and execute:"
        cat $SCRIPT_PATH
        ;;
    "dev2"|"dev-agent02") 
        echo "Connect to Dev-Agent02 (3.14.230.52) and run:"
        echo "Copy the PowerShell script and execute:"
        cat $SCRIPT_PATH
        ;;
    "sales"|"sales-agent01")
        echo "Connect to Sales-Agent01 (3.19.80.124) and run:"
        echo "Copy the PowerShell script and execute:"
        cat $SCRIPT_PATH
        ;;
    "all")
        echo "PowerShell script to run on all Windows instances:"
        echo "=================================="
        cat $SCRIPT_PATH
        echo "=================================="
        echo ""
        echo "RDP Connection commands:"
        echo "./connect-rdp.sh dev1"
        echo "./connect-rdp.sh dev2" 
        echo "./connect-rdp.sh sales"
        ;;
    *)
        echo "Usage: $0 {dev1|dev2|sales|all}"
        echo "  dev1  - Show script for Dev-Opnova-Agent01"
        echo "  dev2  - Show script for Dev-Opnova-Agent02"
        echo "  sales - Show script for Sales-Opnova-Agent01"
        echo "  all   - Show script for all instances"
        ;;
esac
