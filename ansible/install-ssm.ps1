# Install SSM Agent on Windows
Write-Host "Downloading SSM Agent..."
Invoke-WebRequest -Uri "https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/windows_amd64/AmazonSSMAgentSetup.exe" -OutFile "AmazonSSMAgentSetup.exe"

Write-Host "Installing SSM Agent..."
Start-Process -FilePath "AmazonSSMAgentSetup.exe" -ArgumentList "/S" -Wait

Write-Host "Starting SSM Agent service..."
Start-Service AmazonSSMAgent

Write-Host "Setting service to auto-start..."
Set-Service -Name AmazonSSMAgent -StartupType Automatic

Write-Host "SSM Agent installation complete!"
Get-Service AmazonSSMAgent
