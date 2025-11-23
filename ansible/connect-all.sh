#!/bin/bash

echo "Opening RDP connections to all Windows instances..."
echo "Run this PowerShell script in each window:"
echo ""
echo "Invoke-WebRequest -Uri 'https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/windows_amd64/AmazonSSMAgentSetup.exe' -OutFile 'AmazonSSMAgentSetup.exe'"
echo "Start-Process -FilePath 'AmazonSSMAgentSetup.exe' -ArgumentList '/S' -Wait"
echo "Start-Service AmazonSSMAgent"
echo "Set-Service -Name AmazonSSMAgent -StartupType Automatic"
echo ""

# Connect to all instances
export DISPLAY=:0

echo "Connecting to Dev-Agent01..."
xfreerdp /v:13.58.30.31:3389 /u:Administrator /p:'5d6&M;*SARr-Wuq%ifHc(DdgkO-&nZl@' /cert:ignore /size:800x600 &

echo "Connecting to Dev-Agent02..."
xfreerdp /v:3.14.230.52:3389 /u:Administrator /p:'YBwbrb%8d9*zXQ9AKQ9wNfvo96t&Y.sK' /cert:ignore /size:800x600 &

echo "Connecting to Sales-Agent01..."
xfreerdp /v:3.19.80.124:3389 /u:Administrator /p:'vaRgzhZ5pbl5-4!7VjJCtuIM4)FRIpjj' /cert:ignore /size:800x600 &

echo "All RDP connections started. Install SSM Agent in each window."
