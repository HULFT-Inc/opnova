# Download OpNova Agent with Authentication
# Run this script on each Windows machine

# Prompt for credentials
$username = Read-Host "Enter username for get.opnova.io"
$password = Read-Host "Enter password for get.opnova.io" -AsSecureString

# Create credential object
$credential = New-Object System.Management.Automation.PSCredential($username, $password)

# Create temp directory if it doesn't exist
if (!(Test-Path "C:\temp")) {
    New-Item -ItemType Directory -Path "C:\temp"
}

# Download the agent
Write-Host "Downloading OpNova agent..."
try {
    Invoke-WebRequest -Uri "https://get.opnova.io/agent/win/latest" -Credential $credential -OutFile "C:\temp\opnova-agent.exe"
    Write-Host "Download completed successfully!"
    
    # Install the agent
    Write-Host "Installing OpNova agent..."
    Start-Process -FilePath "C:\temp\opnova-agent.exe" -ArgumentList "/S" -Wait
    Write-Host "Installation completed!"
    
} catch {
    Write-Host "Error: $($_.Exception.Message)"
    Write-Host "Please check your credentials and try again."
}
