# Claude Configuration Copy Script

## Overview

This repository now includes a comprehensive shell script (`copy-claude-config.sh`) that allows you to easily copy the Claude Code configuration to other repositories, following Anthropic's best practices for configuration management.

## Files Created

### 1. `copy-claude-config.sh` - Main Copy Script

- **Purpose**: Copies Claude configuration to target repositories
- **Features**:
  - Validates target directory and permissions
  - Creates automatic backups of existing configurations
  - Sets proper file permissions for hook scripts
  - Provides comprehensive error handling and logging
  - Includes post-installation verification
  - Follows security best practices

### 2. `COPY_INSTRUCTIONS.md` - Comprehensive Documentation

- **Purpose**: Detailed instructions for using the copy script
- **Contents**:
  - Step-by-step installation guide
  - Prerequisites and system requirements
  - Best practices for configuration management
  - Troubleshooting guide
  - Advanced customization options

### 3. `example-usage.sh` - Example Script

- **Purpose**: Demonstrates how to use the copy script
- **Features**:
  - Creates a test repository
  - Shows the complete copy process
  - Provides cleanup instructions

## Key Benefits

### 🛡️ Security Best Practices

- Automatic backup creation before overwriting
- Proper file permission management
- Environment variable usage for sensitive data
- Validation of target directory permissions

### 🔧 Developer Experience

- Comprehensive error handling and logging
- Colored output for better readability
- Detailed progress reporting
- Post-installation verification

### 📚 Documentation

- Extensive help system (`--help`, `--version`)
- Detailed usage instructions
- Troubleshooting guide
- Best practices documentation

### 🔄 Automation

- Automated backup creation
- Automatic permission setting
- Verification of installation
- Post-installation guidance

## Quick Usage

```bash
# Make script executable
chmod +x copy-claude-config.sh

# Copy to your project
./copy-claude-config.sh /path/to/your/project

# Get help
./copy-claude-config.sh --help

# Run example
./example-usage.sh
```

## What Gets Copied

The script copies the complete Claude configuration including:

- **`.claude/`** directory with all subdirectories

  - `settings.json` - Global settings and permissions
  - `settings.local.json` - Local settings
  - `hooks/` - Python hook scripts
  - `commands/` - Custom command definitions
  - `agents/` - Specialized AI agents

- **`.mcp.json`** - MCP server configuration
- **`README.md`** - Documentation

## MCP Servers Included

The configuration includes 10+ MCP servers for enhanced capabilities:

- Context7, Linear, Memory, Puppeteer
- Sequential Thinking, DeepWiki, Figma
- PostgreSQL, Playwright, Stripe

## Custom Commands Available

After copying, you'll have access to commands like:

- `/task_easy`, `/task_medium` - Task management
- `/commit`, `/code-review` - Development workflows
- `/analyze`, `/refactor` - Code analysis
- `/security-audit`, `/performance-check` - Specialized tasks

## Specialized Agents

The configuration includes AI agents for:

- Code investigation and analysis
- Flow mapping and planning
- Security auditing and performance optimization
- Documentation generation and code review

## Best Practices Implemented

1. **Error Handling**: Comprehensive error checking and graceful failure
2. **Backup Strategy**: Automatic backup creation with timestamps
3. **Permission Management**: Proper file and directory permissions
4. **Validation**: Target directory validation and verification
5. **Documentation**: Extensive help and usage documentation
6. **Security**: Environment variable usage and permission validation
7. **Logging**: Detailed progress reporting with timestamps
8. **Verification**: Post-installation verification and testing

## Compatibility

- **Operating Systems**: macOS, Linux (Unix-like systems)
- **Shell**: Bash
- **Dependencies**: Python 3.8+, Node.js, Git (recommended)
- **Claude Code**: Compatible with latest versions

## Support

For issues or questions:

1. Check the troubleshooting section in `COPY_INSTRUCTIONS.md`
2. Review the help output: `./copy-claude-config.sh --help`
3. Verify your system meets the prerequisites
4. Check file permissions and directory access

---

This copy script makes it easy to share and deploy Claude Code configurations across multiple projects while maintaining security, following best practices, and providing comprehensive documentation and support.
