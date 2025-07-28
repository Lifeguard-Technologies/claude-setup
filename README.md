# Claude Code Configuration Setup

> A powerful, production-ready configuration framework for Claude Code featuring Model Context Protocol (MCP) servers, intelligent AI agents, custom commands, and automated workflows.

[![Claude Code](https://img.shields.io/badge/Claude%20Code-Compatible-blue.svg)](https://claude.ai/code)
[![MCP](https://img.shields.io/badge/MCP-Enabled-green.svg)](https://modelcontextprotocol.io/)
[![Python](https://img.shields.io/badge/Python-3.8+-blue.svg)](https://python.org)
[![Node.js](https://img.shields.io/badge/Node.js-Required-brightgreen.svg)](https://nodejs.org)

## 🚀 Quick Start (2 Minutes)

```bash
# 1. Clone this repository
git clone <this-repo-url> claude-setup
cd claude-setup

# 2. Copy configuration to your project
./copy-claude-config.sh /path/to/your/project

# 3. Install uv (if not already installed)
curl -LsSf https://astral.sh/uv/install.sh | sh

# 4. Start using advanced features
cd /path/to/your/project
# In Claude Code, try:
# /task implement user authentication
# /analyze optimize database queries
# /security-audit
```

## 📋 Table of Contents

- [Overview](#overview)
- [What You Get](#what-you-get)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Features](#features)
  - [Custom Commands](#custom-commands)
  - [AI Agents](#ai-agents)
  - [MCP Servers](#mcp-servers)
  - [Automation Hooks](#automation-hooks)
- [Usage Examples](#usage-examples)
- [Configuration](#configuration)
- [Troubleshooting](#troubleshooting)
- [Advanced Setup](#advanced-setup)

## 🎯 Overview

This repository provides a comprehensive configuration setup that transforms Claude Code into a powerful development assistant with:

- **16+ Custom Commands**: From intelligent commits to security audits
- **8+ Specialized AI Agents**: Each with unique expertise and tools
- **10+ MCP Servers**: Extended capabilities for databases, browsers, APIs, and more
- **Automated Workflows**: Smart hooks that streamline your development process
- **Easy Distribution**: One-command setup for any project

## 🎁 What You Get

### Instant Access To:

1. **Intelligent Task Routing** - Automatically analyzes task complexity and routes to the right workflow
2. **Multi-Agent Workflows** - Specialized agents work together on complex problems
3. **Automated Code Reviews** - Pre-commit quality checks and suggestions
4. **Smart Git Integration** - Branch suggestions, conventional commits, PR creation
5. **Security & Performance Analysis** - Built-in auditing and optimization
6. **Documentation Generation** - Automated docs from your codebase
7. **Browser Automation** - Web scraping and testing capabilities
8. **Database Connectivity** - Direct PostgreSQL access
9. **API Integrations** - Linear, Stripe, Figma, and more

## 📦 Prerequisites

### Required Software

| Software | Version | Check Command | Installation |
|----------|---------|---------------|--------------|
| **Claude Code** | Latest | `claude --version` | [Download](https://claude.ai/download) |
| **Python** | 3.8+ | `python3 --version` | [Download](https://python.org) |
| **Node.js** | 16+ | `node --version` | [Download](https://nodejs.org) |
| **Git** | Any | `git --version` | [Download](https://git-scm.com) |

### Quick Prerequisites Check

```bash
# Run this to check all prerequisites
for cmd in claude python3 node git; do
    if command -v $cmd &> /dev/null; then
        echo "✅ $cmd is installed"
    else
        echo "❌ $cmd is NOT installed"
    fi
done
```

## 📥 Installation

### Method 1: Automated Setup (Recommended)

```bash
# 1. Clone this repository
git clone <this-repo-url> claude-setup
cd claude-setup

# 2. Run the copy script on your target project
./copy-claude-config.sh /path/to/your/project

# 3. Install uv (Python package manager)
curl -LsSf https://astral.sh/uv/install.sh | sh

# 4. Verify installation
cd /path/to/your/project
ls -la .claude/  # Should see configuration files
```

### Method 2: Manual Setup

```bash
# 1. Copy configuration files
cp -r claude-setup/.claude /path/to/your/project/
cp claude-setup/.mcp.json /path/to/your/project/

# 2. Set permissions
chmod +x /path/to/your/project/.claude/hooks/*.py

# 3. Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### Post-Installation Setup

```bash
# 1. Set up environment variables (optional)
export LINEAR_API_KEY="your_key"        # For Linear integration
export STRIPE_SECRET_KEY="your_key"     # For Stripe integration
export DATABASE_URL="postgres://..."    # For PostgreSQL

# 2. Customize project settings
# Edit .claude/settings.local.json for project-specific configuration
```

## ✨ Features

### 🎮 Custom Commands

#### Task Management Commands

| Command | Description | Example |
|---------|-------------|---------|
| `/task` | Intelligent task routing based on complexity | `/task implement user auth` |
| `/analyze` | Deep codebase analysis with multi-agent workflow | `/analyze optimize performance` |
| `/fix` | Direct implementation for simple fixes | `/fix typo in README` |
| `/hotfix` | Emergency fixes with streamlined workflow | `/hotfix critical security issue` |

#### Development Commands

| Command | Description | Example |
|---------|-------------|---------|
| `/commit` | Smart commits with conventional standards | `/commit` |
| `/code-review` | Automated review of uncommitted changes | `/code-review` |
| `/refactor` | Guided refactoring with best practices | `/refactor improve UserService` |
| `/debug` | Systematic debugging assistance | `/debug API endpoint failing` |
| `/test` | Test creation and execution | `/test UserController` |

#### Specialized Commands

| Command | Description | Example |
|---------|-------------|---------|
| `/security-audit` | Comprehensive security analysis | `/security-audit` |
| `/performance-check` | Performance bottleneck detection | `/performance-check database queries` |
| `/doc-gen` | Automated documentation creation | `/doc-gen API endpoints` |
| `/pr` | Create pull requests with AI-generated descriptions | `/pr` |

### 🤖 AI Agents

#### Investigation & Analysis Agents

1. **investigator** - Expert code investigator
   - Uses sequential thinking for deep analysis
   - Finds all related code to a problem
   - Generates `INVESTIGATION_REPORT.md`

2. **code-flow-mapper** - Execution path tracer
   - Maps code flow and file relationships
   - Identifies dependencies and connections
   - Creates `FLOW_REPORT.md`

3. **planner** - Strategic implementation planner
   - Reads investigation and flow reports
   - Creates comprehensive implementation plans
   - Outputs `PLAN.md` with step-by-step guidance

#### Specialized Agents

4. **task-router** - Intelligent task analyzer
   - Analyzes task complexity
   - Routes to appropriate workflow
   - Suggests best approach

5. **code-reviewer** - Senior code review specialist
   - Reviews for quality, security, maintainability
   - Provides prioritized feedback
   - Suggests specific improvements

6. **security-auditor** - Security vulnerability scanner
   - Detects common vulnerabilities
   - Suggests security best practices
   - Prioritizes critical issues

7. **performance-analyzer** - Performance optimization expert
   - Identifies bottlenecks
   - Suggests optimizations
   - Database query analysis

8. **doc-generator** - Documentation specialist
   - Creates API documentation
   - Generates README files
   - Maintains code comments

### 🔌 MCP Servers

| Server | Purpose | Key Features |
|--------|---------|--------------|
| **context7** | Enhanced context management | 6000+ token minimum, smart context |
| **linear** | Project management | Create/update issues, track progress |
| **memory** | Persistent storage | Remember across sessions |
| **puppeteer** | Browser automation | Web scraping, testing |
| **sequential-thinking** | Advanced reasoning | Complex problem solving |
| **postgres** | Database access | Direct SQL queries |
| **stripe** | Payment processing | Manage products, prices |
| **figma** | Design integration | Access design assets |
| **playwright** | Advanced browser control | E2E testing |
| **mcp-deepwiki** | Documentation fetch | Repository docs access |

### ⚡ Automation Hooks

1. **task_prep_hook.py**
   - Triggers on: `/task`, `/analyze` commands
   - Creates organized `claude-instance-{id}` directories
   - Maintains clean project structure

2. **branch_manager_hook.py**
   - Suggests appropriate git branches
   - Maps commands to branch types
   - Follows git flow conventions

3. **pre_commit_hook.py**
   - Runs quality checks before commits
   - Ensures code standards
   - Prevents common mistakes

## 📚 Usage Examples

### Example 1: Complex Feature Implementation

```bash
# In Claude Code:
/task implement user authentication with JWT tokens

# What happens:
# 1. task-router analyzes complexity → routes to /analyze
# 2. Creates claude-instance-1/ directory
# 3. investigator searches for auth-related code
# 4. code-flow-mapper traces current auth flow
# 5. planner creates detailed implementation plan
# 6. You review and approve the plan
# 7. Implementation begins with all context
```

### Example 2: Code Quality Workflow

```bash
# After making changes:
/code-review
# Reviews your uncommitted changes
# Provides prioritized feedback

# After addressing feedback:
/commit
# Creates conventional commit with perfect message
```

### Example 3: Performance Optimization

```bash
/performance-check analyze slow API endpoints

# Automatically:
# - Identifies performance bottlenecks
# - Analyzes database queries
# - Suggests optimizations
# - Provides implementation examples
```

### Example 4: Security Audit

```bash
/security-audit

# Performs:
# - Vulnerability scanning
# - Dependency checking
# - Security best practices review
# - Prioritized fix recommendations
```

## ⚙️ Configuration

### Directory Structure

```
your-project/
├── .claude/
│   ├── settings.json          # Global permissions & hooks
│   ├── settings.local.json    # Project-specific settings
│   ├── agents/               # AI agent definitions
│   │   ├── investigator.md
│   │   ├── code-flow-mapper.md
│   │   ├── planner.md
│   │   └── ... (8+ agents)
│   ├── commands/             # Custom command definitions
│   │   ├── task.md
│   │   ├── analyze.md
│   │   ├── commit.md
│   │   └── ... (16+ commands)
│   └── hooks/               # Automation scripts
│       ├── task_prep_hook.py
│       ├── branch_manager_hook.py
│       └── pre_commit_hook.py
├── .mcp.json                # MCP server configuration
└── claude-instance-*/       # Auto-created task directories
```

### Key Configuration Files

#### `.claude/settings.json`
- Defines allowed/denied commands
- Configures hooks
- Sets MCP server permissions
- Manages security policies

#### `.claude/settings.local.json`
- Project-specific overrides
- Environment-specific settings
- Custom configurations

#### `.mcp.json`
- MCP server definitions
- API key configurations
- Server-specific settings

## 🔧 Troubleshooting

### Common Issues & Solutions

#### 1. "Hook not triggering"

```bash
# Check uv installation
uv --version

# Fix permissions
chmod +x .claude/hooks/*.py

# Verify hook in settings.json
cat .claude/settings.json | grep -A5 "hooks"
```

#### 2. "MCP server not loading"

```bash
# Check Node.js
node --version  # Should be 16+

# Test MCP manually
npx -y @upstash/context7-mcp

# Check .mcp.json syntax
python3 -m json.tool .mcp.json
```

#### 3. "Permission denied errors"

```bash
# Fix all permissions at once
find .claude -name "*.py" -exec chmod +x {} \;
chmod 755 .claude
```

#### 4. "Python scripts failing"

```bash
# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Open new terminal or:
source ~/.bashrc  # or ~/.zshrc

# Verify
uv --version
```

### Debug Mode

```bash
# Enable verbose logging in Claude Code
export CLAUDE_DEBUG=1

# Check logs
tail -f ~/.claude/logs/
```

## 🚀 Advanced Setup

### Adding Custom Commands

Create `.claude/commands/my-command.md`:

```markdown
/my-command
Custom command for specific workflow

ARGS: task_description

Workflow:
1. Analyze the task
2. Use specialized agents
3. Implement solution
```

### Creating Custom Agents

Create `.claude/agents/my-agent.md`:

```markdown
You are an expert in [domain].

Tools: Task, Read, Write, Bash

Responsibilities:
- Specific task 1
- Specific task 2

Always follow best practices for [domain].
```

### Environment Variables

```bash
# Create .env file
cat > .env << EOF
LINEAR_API_KEY=your_key
STRIPE_SECRET_KEY=your_key
DATABASE_URL=postgres://user:pass@host:5432/db
EOF

# Source in your shell profile
echo 'source /path/to/project/.env' >> ~/.zshrc
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/amazing-feature`
3. Commit changes: `git commit -m 'Add amazing feature'`
4. Push to branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

## 📄 License

This configuration framework is provided as-is for enhancing Claude Code capabilities. See LICENSE file for details.

## 🆘 Support

- **Documentation**: [Claude Code Docs](https://docs.anthropic.com/claude-code)
- **Issues**: [GitHub Issues](https://github.com/your-repo/issues)
- **Community**: [Discord/Forum Link]

---

**Built with ❤️ to supercharge your Claude Code experience**