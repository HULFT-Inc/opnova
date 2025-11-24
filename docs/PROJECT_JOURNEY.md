# OpNova Project Journey - How We Got Here

## Overview
This document chronicles the complete setup of the OpNova project infrastructure using Amazon Q Developer, from initial AWS EC2 instances to a fully automated Ansible-managed Windows environment.

## Phase 1: Infrastructure Discovery (2025-11-21)

### Initial State
- 3 Windows EC2 instances running in AWS us-east-2
- No remote management capabilities
- Manual RDP access only

### Key Actions
1. **AWS Environment Assessment**
   ```bash
   aws ec2 describe-instances --profile opnova --region us-east-2
   ```
   - Discovered 3 Windows Server 2025 instances
   - All in same subnet (subnet-064057b9f2774bfce)
   - Security group: sg-0241e92a52b4532ea

2. **Network Connectivity Setup**
   - Added RDP access (port 3389) to security group
   - Tested connectivity: `nc -zv <ip> 3389`
   - All instances accessible via RDP

## Phase 2: Remote Access Setup (2025-11-21)

### RDP Client Configuration
1. **Installed FreeRDP on macOS**
   ```bash
   brew install freerdp
   brew install --cask xquartz
   ```

2. **Created Connection Scripts**
   - `connect-rdp.sh` - Automated RDP connections
   - Stored Windows passwords securely
   - Configured for all 3 instances

### Instance Details
- **Dev-Opnova-Agent01**: 13.58.30.31 (i-049a2559b8f6e8316)
- **Dev-Opnova-Agent02**: 3.14.230.52 (i-044baa0fced751b70)  
- **Sales-Opnova-Agent01**: 3.19.80.124 (i-06a4b78156ce85ba3)

## Phase 3: AWS Systems Manager Setup (2025-11-21)

### Challenge: WinRM Connectivity Issues
- Initial attempt to use Ansible with WinRM failed
- Windows instances lacked proper configuration
- Security group missing WinRM ports (5985, 5986)

### Solution: AWS SSM Agent
1. **Manual SSM Agent Installation**
   - RDP to each instance
   - Downloaded and installed SSM Agent
   ```powershell
   Invoke-WebRequest -Uri "https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/windows_amd64/AmazonSSMAgentSetup.exe" -OutFile "AmazonSSMAgentSetup.exe"
   Start-Process -FilePath "AmazonSSMAgentSetup.exe" -ArgumentList "/S" -Wait
   Start-Service AmazonSSMAgent
   ```

2. **IAM Role Configuration**
   ```bash
   aws iam create-role --role-name EC2-SSM-Role
   aws iam attach-role-policy --role-name EC2-SSM-Role --policy-arn arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore
   aws iam create-instance-profile --instance-profile-name EC2-SSM-InstanceProfile
   aws ec2 associate-iam-instance-profile --instance-id <id> --iam-instance-profile Name=EC2-SSM-InstanceProfile
   ```

3. **Verification**
   ```bash
   aws ssm describe-instance-information --profile opnova --region us-east-2
   aws ssm send-command --instance-ids <id> --document-name "AWS-RunPowerShellScript"
   ```

## Phase 4: Backup Strategy (2025-11-23)

### EBS Snapshots
Created point-in-time backups of all instances:
```bash
aws ec2 create-snapshot --volume-id vol-0e0657fc7c36d5420 --description "Backup of Dev-Opnova-Agent01"
aws ec2 create-snapshot --volume-id vol-046bd074a41e6b451 --description "Backup of Dev-Opnova-Agent02"  
aws ec2 create-snapshot --volume-id vol-041192ccd74295bf2 --description "Backup of Sales-Opnova-Agent01"
```

**Snapshot IDs:**
- Dev-Agent01: snap-06a76472d3645a805
- Dev-Agent02: snap-0a5558e20093ea9cd
- Sales-Agent01: snap-03e7a57a037211750

## Phase 5: Audit Logging System (2025-11-23)

### Project Transparency Initiative
Created comprehensive audit logging for all Amazon Q Developer interactions:

1. **Audit Structure**
   ```
   audit/
   ├── sessions/     # Q Developer session logs
   ├── commands/     # Command history
   ├── configs/      # Configuration changes
   ├── scripts/      # Automation tools
   └── exports/      # Shareable formats
   ```

2. **Automation Scripts**
   - `log-session.sh` - Session logging template
   - `export-audit.sh` - Multi-format exports (JSON, HTML, Archive)
   - Git hooks for automatic commit logging

3. **GitHub Integration**
   ```bash
   gh repo create HULFT-Inc/opnova --public --source=. --remote=origin --push
   ```
   Repository: https://github.com/HULFT-Inc/opnova

## Phase 6: Ansible Automation (2025-11-24)

### Challenge: macOS Python Fork Issues
- Standard Ansible installation crashed on macOS
- WinRM connectivity still problematic

### Solution: Ansible + AWS SSM Integration
1. **Python Virtual Environment**
   ```bash
   python3 -m venv ansible-venv
   source ansible-venv/bin/activate
   pip install ansible pywinrm
   export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES  # macOS fix
   ```

2. **SSM-Based Playbooks**
   Instead of direct WinRM, used AWS SSM for Windows management:
   ```yaml
   - name: Install software via SSM
     shell: |
       aws ssm send-command \
         --instance-ids {{ instance_ids | join(' ') }} \
         --document-name "AWS-RunPowerShellScript" \
         --parameters 'commands=["choco install git -y"]'
   ```

3. **Automated Software Deployment**
   - Chocolatey package manager
   - Development tools (VS Code, Git, Chrome, Firefox)
   - Runtime environments (Java, Node.js)
   - Windows features (IIS)

## Key Learnings

### Technical Insights
1. **SSM > WinRM**: AWS Systems Manager more reliable than WinRM for Windows automation
2. **IAM Roles Critical**: EC2 instances need proper IAM roles for SSM connectivity
3. **macOS Python Issues**: Virtual environments + fork safety flag required
4. **Backup First**: Always create snapshots before major changes

### Process Improvements
1. **Audit Everything**: Comprehensive logging enables knowledge sharing
2. **Version Control**: Git repository essential for team collaboration  
3. **Automation Scripts**: Reduce manual steps with shell scripts
4. **Documentation**: Real-time documentation prevents knowledge loss

## Current State

### Infrastructure
- ✅ 3 Windows instances with SSM connectivity
- ✅ Automated backup snapshots
- ✅ Secure RDP access with stored credentials
- ✅ Development tools installed via Ansible

### Automation
- ✅ Ansible playbooks for Windows management
- ✅ AWS CLI integration for SSM commands
- ✅ Automated software deployment pipeline
- ✅ Configuration management via code

### Documentation & Sharing
- ✅ GitHub repository with full audit trail
- ✅ Session logging for all Q Developer interactions
- ✅ Export utilities for stakeholder sharing
- ✅ Comprehensive project documentation

## Next Steps
1. Implement CloudWatch monitoring
2. Set up automated backup scheduling
3. Create disaster recovery procedures
4. Expand Ansible playbooks for application deployment
5. Implement infrastructure as code (Terraform/CloudFormation)

---
*This journey demonstrates the power of Amazon Q Developer for rapid infrastructure setup and the importance of comprehensive documentation for team knowledge sharing.*
