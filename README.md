# OpNova Project

A comprehensive Windows infrastructure automation project built with Amazon Q Developer, featuring complete audit logging and team collaboration capabilities.

## 🚀 Overview

OpNova demonstrates modern infrastructure management using:
- **AWS EC2** Windows instances with Systems Manager
- **Ansible** automation via AWS SSM (no WinRM required)
- **Comprehensive audit logging** of all Amazon Q Developer interactions
- **Git-based collaboration** with automated documentation

## 📋 Quick Start

```bash
# Clone and set up
git clone https://github.com/HULFT-Inc/opnova.git
cd opnova

# Install dependencies
brew install freerdp
cd ansible && python3 -m venv ansible-venv && source ansible-venv/bin/activate
pip install ansible pywinrm

# Deploy to Windows instances
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
ansible-playbook windows-complete-setup.yml
```

## 🏗️ Infrastructure

### AWS Resources
- **3 Windows Server 2025 instances** (t3.large/medium)
- **AWS Systems Manager** for remote management
- **IAM roles** with SSM permissions
- **EBS snapshots** for backup/recovery
- **Security groups** with controlled access

### Instance Details
| Name | Instance ID | IP Address | Purpose |
|------|-------------|------------|---------|
| Dev-Agent01 | i-049a2559b8f6e8316 | 13.58.30.31 | Development |
| Dev-Agent02 | i-044baa0fced751b70 | 3.14.230.52 | Development |
| Sales-Agent01 | i-06a4b78156ce85ba3 | 3.19.80.124 | Sales Demo |

## 🔧 Features

### Automation
- **Ansible playbooks** for Windows configuration
- **Chocolatey** package management
- **Development tools** deployment (VS Code, Git, Chrome, etc.)
- **Windows features** configuration (IIS, etc.)

### Management
- **RDP access** with FreeRDP on macOS
- **AWS CLI** integration for SSM commands
- **Backup automation** with EBS snapshots
- **Security** with IP-restricted access

### Documentation & Audit
- **Session logging** for all Amazon Q Developer interactions
- **Command history** tracking
- **Export utilities** (JSON, HTML, Archive formats)
- **Git hooks** for automatic commit logging

## 📁 Project Structure

```
opnova/
├── ansible/                 # Automation playbooks
│   ├── windows-complete-setup.yml
│   ├── ssm-setup.yml
│   └── connect-rdp.sh
├── audit/                   # Audit logging system
│   ├── sessions/           # Q Developer session logs
│   ├── commands/           # Command history
│   └── scripts/            # Automation utilities
├── docs/                    # Documentation
│   ├── PROJECT_JOURNEY.md  # How we got here
│   ├── ARCHITECTURE.md     # Technical overview
│   └── QUICK_START.md      # Getting started
└── src/                     # Micronaut application
```

## 🎯 Use Cases

### Development Teams
- Rapid Windows environment provisioning
- Consistent development tool deployment
- Automated configuration management
- Team knowledge sharing via audit logs

### DevOps/Infrastructure
- Infrastructure as Code practices
- Automated backup and recovery
- Security compliance with audit trails
- Multi-environment management

### Project Management
- Complete visibility into all changes
- Amazon Q Developer interaction tracking
- Exportable reports for stakeholders
- Version-controlled documentation

## 📖 Documentation

- **[Project Journey](docs/PROJECT_JOURNEY.md)** - Complete setup walkthrough
- **[Architecture](docs/ARCHITECTURE.md)** - Technical diagrams and details
- **[Quick Start](docs/QUICK_START.md)** - Get up and running fast

## 🔍 Audit & Transparency

Every Amazon Q Developer interaction is logged with:
- Session objectives and outcomes
- Commands executed and results
- Decisions made and rationale
- Issues encountered and solutions
- Lessons learned and next steps

Export formats available: JSON, HTML, Archive

## 🛠️ Technology Stack

- **Cloud**: AWS EC2, IAM, Systems Manager, EBS
- **Automation**: Ansible, AWS CLI, PowerShell
- **Development**: Micronaut, Java, Gradle
- **Documentation**: Markdown, Git, GitHub
- **Local Tools**: FreeRDP, XQuartz, Python venv

## 🤝 Contributing

1. Clone the repository
2. Create a feature branch
3. Use audit logging: `./audit/scripts/log-session.sh "Feature Name" "Description"`
4. Make changes and commit with descriptive messages
5. Push and create pull request

## 📊 Metrics

- **3** Windows instances managed
- **100%** automation coverage for software deployment
- **Complete** audit trail of all Amazon Q Developer interactions
- **Zero** manual configuration steps required for new team members

## 🔗 Links

- **Repository**: https://github.com/HULFT-Inc/opnova
- **AWS Console**: us-east-2 region
- **Documentation**: `/docs/` directory

---

*Built with Amazon Q Developer - demonstrating the power of AI-assisted infrastructure automation with complete transparency and audit capabilities.*
