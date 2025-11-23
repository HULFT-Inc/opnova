# Session: Windows SSM Setup
**Date:** 2025-11-23  
**Duration:** ~4 hours  
**Participants:** Drew, Amazon Q Developer

## Objective
Set up AWS Systems Manager on Windows EC2 instances for remote management

## Key Actions
1. **RDP Access Setup**
   - Configured FreeRDP on macOS
   - Added IP to security group for RDP (port 3389)
   - Created connection scripts with passwords

2. **SSM Agent Installation**
   - Downloaded and installed SSM Agent on all 3 instances
   - Created IAM role: `EC2-SSM-Role`
   - Attached `AmazonSSMManagedInstanceCore` policy
   - Associated IAM instance profiles

3. **Remote Management**
   - Verified SSM connectivity on all instances
   - Tested PowerShell commands via AWS CLI
   - Created backup snapshots

## AWS Resources Created
- IAM Role: `EC2-SSM-Role`
- Instance Profile: `EC2-SSM-InstanceProfile`
- Security Group Rules: RDP (3389), WinRM (5985, 5986)
- EBS Snapshots: 3 backups created

## Commands Executed
```bash
# Key commands logged in commands/ directory
aws ssm describe-instance-information
aws ssm send-command --instance-ids i-044baa0fced751b70
aws ec2 create-snapshot --volume-id vol-046bd074a41e6b451
```

## Lessons Learned
- Windows instances need IAM roles for SSM connectivity
- SSM Agent requires restart after IAM role attachment
- RDP passwords should be stored in Ansible Vault
- Backup snapshots are essential before major changes

## Next Steps
- Implement automated backup scheduling
- Set up CloudWatch monitoring
- Create Ansible playbooks for configuration management
