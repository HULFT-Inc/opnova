# Enable WinRM for Ansible connectivity
Write-Host "Enabling WinRM..."

# Enable WinRM service
Enable-PSRemoting -Force

# Configure WinRM for HTTPS
winrm quickconfig -transport:https -force

# Set WinRM service to auto-start
Set-Service -Name WinRM -StartupType Automatic

# Configure WinRM settings
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="1024"}'

# Create firewall rule for WinRM HTTPS
New-NetFirewallRule -DisplayName "WinRM HTTPS" -Direction Inbound -Protocol TCP -LocalPort 5986 -Action Allow

Write-Host "WinRM enabled successfully!"
Get-Service WinRM
