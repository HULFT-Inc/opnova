# OpNova Technical Architecture

## Infrastructure Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                        AWS us-east-2                            │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │                VPC: vpc-04dd75c6d411db544              │   │
│  │                                                         │   │
│  │  ┌─────────────────────────────────────────────────┐   │   │
│  │  │         Subnet: subnet-064057b9f2774bfce        │   │   │
│  │  │                                                 │   │   │
│  │  │  ┌─────────────────┐  ┌─────────────────┐      │   │   │
│  │  │  │ Dev-Agent01     │  │ Dev-Agent02     │      │   │   │
│  │  │  │ i-049a25...     │  │ i-044baa...     │      │   │   │
│  │  │  │ 13.58.30.31     │  │ 3.14.230.52     │      │   │   │
│  │  │  │ Windows 2025    │  │ Windows 2025    │      │   │   │
│  │  │  │ t3.large        │  │ t3.large        │      │   │   │
│  │  │  └─────────────────┘  └─────────────────┘      │   │   │
│  │  │                                                 │   │   │
│  │  │  ┌─────────────────┐                           │   │   │
│  │  │  │ Sales-Agent01   │                           │   │   │
│  │  │  │ i-06a4b7...     │                           │   │   │
│  │  │  │ 3.19.80.124     │                           │   │   │
│  │  │  │ Windows 2025    │                           │   │   │
│  │  │  │ t3.medium       │                           │   │   │
│  │  │  └─────────────────┘                           │   │   │
│  │  └─────────────────────────────────────────────────┘   │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │                    IAM Resources                        │   │
│  │  • EC2-SSM-Role                                        │   │
│  │  • EC2-SSM-InstanceProfile                             │   │
│  │  • AmazonSSMManagedInstanceCore Policy                 │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │                 Security Groups                         │   │
│  │  sg-0241e92a52b4532ea                                  │   │
│  │  • RDP (3389) from 54.208.10.208/32                   │   │
│  │  • WinRM HTTP (5985) from 54.208.10.208/32            │   │
│  │  • WinRM HTTPS (5986) from 54.208.10.208/32           │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │                  EBS Snapshots                          │   │
│  │  • snap-06a76472d3645a805 (Dev-Agent01)               │   │
│  │  • snap-0a5558e20093ea9cd (Dev-Agent02)               │   │
│  │  • snap-03e7a57a037211750 (Sales-Agent01)             │   │
│  └─────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                    Local Development                            │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │                 macOS Workstation                       │   │
│  │                                                         │   │
│  │  ┌─────────────────┐  ┌─────────────────┐              │   │
│  │  │ FreeRDP + XQuartz│  │ Ansible + venv  │              │   │
│  │  │ • RDP Access    │  │ • Python 3      │              │   │
│  │  │ • GUI Management│  │ • pywinrm       │              │   │
│  │  └─────────────────┘  └─────────────────┘              │   │
│  │                                                         │   │
│  │  ┌─────────────────┐  ┌─────────────────┐              │   │
│  │  │ AWS CLI         │  │ Git Repository  │              │   │
│  │  │ • SSM Commands  │  │ • Audit Logs    │              │   │
│  │  │ • EC2 Management│  │ • Documentation │              │   │
│  │  └─────────────────┘  └─────────────────┘              │   │
│  └─────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
```

## Management Flow

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│ Amazon Q        │    │ Local macOS     │    │ AWS EC2         │
│ Developer       │───▶│ Workstation     │───▶│ Windows         │
│                 │    │                 │    │ Instances       │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│ • Session Logs  │    │ • Ansible       │    │ • SSM Agent     │
│ • Audit Trail   │    │ • AWS CLI       │    │ • Chocolatey    │
│ • Documentation │    │ • Git Repo      │    │ • Dev Tools     │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## Communication Protocols

1. **RDP (Port 3389)**
   - Direct GUI access to Windows instances
   - Used for initial setup and troubleshooting
   - Secured with IP restrictions

2. **AWS Systems Manager**
   - Primary automation channel
   - PowerShell command execution
   - No direct network connectivity required

3. **Git/GitHub**
   - Version control for all configurations
   - Audit trail storage
   - Team collaboration

## Security Model

- **Network**: Security groups restrict access to specific IP
- **Authentication**: AWS IAM roles for service access
- **Encryption**: EBS volumes and snapshots
- **Audit**: Complete logging of all actions
- **Backup**: Regular EBS snapshots for recovery

## Automation Stack

- **Infrastructure**: AWS EC2, IAM, Security Groups
- **Configuration**: Ansible playbooks via SSM
- **Package Management**: Chocolatey on Windows
- **Version Control**: Git with automated audit logging
- **Documentation**: Markdown with export utilities
