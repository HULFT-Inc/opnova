# OpNova Quick Start Guide

## Prerequisites
- AWS CLI configured with `opnova` profile
- macOS with Homebrew installed
- Git and GitHub CLI

## 1. Clone Repository
```bash
git clone https://github.com/HULFT-Inc/opnova.git
cd opnova
```

## 2. Set Up RDP Access
```bash
# Install FreeRDP and XQuartz
brew install freerdp
brew install --cask xquartz

# Connect to instances
./ansible/connect-rdp.sh dev1    # Dev-Agent01
./ansible/connect-rdp.sh dev2    # Dev-Agent02  
./ansible/connect-rdp.sh sales   # Sales-Agent01
```

## 3. Set Up Ansible
```bash
cd ansible

# Create Python virtual environment
python3 -m venv ansible-venv
source ansible-venv/bin/activate
pip install ansible pywinrm

# Set macOS compatibility
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
```

## 4. Deploy Software
```bash
# Install basic tools
ansible-playbook ssm-setup.yml

# Full development environment
ansible-playbook windows-complete-setup.yml
```

## 5. Verify Deployment
```bash
# Check SSM connectivity
aws ssm describe-instance-information --profile opnova --region us-east-2

# Test command execution
aws ssm send-command \
  --instance-ids i-044baa0fced751b70 \
  --document-name "AWS-RunPowerShellScript" \
  --parameters 'commands=["Get-Service | Where-Object {$_.Status -eq \"Running\"}"]' \
  --profile opnova --region us-east-2
```

## 6. Start Audit Logging
```bash
# Create new session log
./audit/scripts/log-session.sh "My Session" "Working on feature X"

# Start command logging
script -a audit/commands/$(date +%Y-%m-%d)-commands.log
```

## Instance Details
- **Dev-Agent01**: i-049a2559b8f6e8316 (13.58.30.31)
- **Dev-Agent02**: i-044baa0fced751b70 (3.14.230.52)
- **Sales-Agent01**: i-06a4b78156ce85ba3 (3.19.80.124)

## Common Commands
```bash
# Backup all instances
aws ec2 create-snapshot --volume-id vol-0e0657fc7c36d5420 --description "Backup $(date)"

# Export audit logs
./audit/scripts/export-audit.sh

# Connect to all instances
./ansible/connect-all.sh

# Run PowerShell on all instances
aws ssm send-command \
  --instance-ids i-044baa0fced751b70 i-049a2559b8f6e8316 i-06a4b78156ce85ba3 \
  --document-name "AWS-RunPowerShellScript" \
  --parameters 'commands=["Your-Command-Here"]' \
  --profile opnova --region us-east-2
```

## Troubleshooting
- **RDP not connecting**: Check security group allows your IP on port 3389
- **SSM commands failing**: Verify IAM instance profiles are attached
- **Ansible crashes**: Ensure `OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES` is set
- **Python issues**: Use virtual environment and activate before running Ansible

## Support
- Repository: https://github.com/HULFT-Inc/opnova
- Documentation: `/docs/` directory
- Audit logs: `/audit/sessions/` directory
