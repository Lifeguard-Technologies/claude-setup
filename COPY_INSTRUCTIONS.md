# Claude Configuration Copy Instructions

This document provides comprehensive instructions for copying Claude Code configuration to other repositories using the provided shell script, following Anthropic's best practices.

## Quick Start

```bash
# Make the script executable (if not already done)
chmod +x copy-claude-config.sh

# Copy configuration to your target repository
./copy-claude-config.sh /path/to/your/project
```

## What Gets Copied

The script copies the following configuration files and directories:

### Core Configuration Files

- **`.claude/`** - Main configuration directory containing:

  - `settings.json` - Global Claude settings and permissions
  - `settings.local.json` - Local/project-specific settings
  - `hooks/` - Python hook scripts for automated workflows
  - `commands/` - Custom command definitions
  - `agents/` - Specialized AI agent configurations

- **`.mcp.json`** - Model Context Protocol server configuration
- **`README.md`** - Documentation and setup instructions

### MCP Servers Included

- **Context7** - Enhanced context management
- **Linear** - Project management integration
- **Memory** - Persistent memory storage
- **Puppeteer** - Web automation capabilities
- **Sequential Thinking** - Advanced reasoning tools
- **DeepWiki** - Knowledge base integration
- **Figma** - Design tool integration
- **PostgreSQL** - Database connectivity
- **Playwright** - Browser automation
- **Stripe** - Payment processing

## Prerequisites

Before running the script, ensure your target environment has:

### Required Software

- **Claude Code**: Installed and configured
- **Python 3.8+**: For hook script execution
- **uv**: Python package manager (recommended)
- **Node.js**: For MCP server functionality
- **Git**: For version control (recommended)

### System Requirements

- Unix-like operating system (macOS, Linux)
- Bash shell
- Write permissions to target directory

## Installation Steps

### 1. Prepare Your Target Repository

```bash
# Navigate to your target project
cd /path/to/your/project

# Initialize git repository (if not already done)
git init

# Ensure you have write permissions
ls -la
```

### 2. Run the Copy Script

```bash
# From the claude-setup directory
./copy-claude-config.sh /path/to/your/project
```

### 3. Install Dependencies

```bash
# Navigate to your target project
cd /path/to/your/project

# Install uv (Python package manager)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Verify installation
uv --version
```

### 4. Configure Environment Variables

Edit `.claude/settings.local.json` for project-specific settings:

```json
{
  "projectName": "Your Project Name",
  "environment": "development",
  "customSettings": {
    "yourSetting": "value"
  }
}
```

Set up any required API keys in your environment:

```bash
# Example: Set up Linear API key
export LINEAR_API_KEY="your_linear_api_key"

# Example: Set up Stripe API key
export STRIPE_SECRET_KEY="your_stripe_secret_key"
```

## Best Practices

### Security Considerations

1. **Review Permissions**: Check `.claude/settings.json` for allowed commands
2. **API Keys**: Store sensitive keys in environment variables, not in config files
3. **Backup**: The script automatically creates backups of existing configurations
4. **Version Control**: Commit configuration changes to track modifications

### Configuration Management

1. **Local Settings**: Use `settings.local.json` for project-specific configurations
2. **Environment Variables**: Use environment variables for sensitive data
3. **Customization**: Modify commands and agents in their respective directories
4. **Documentation**: Update README.md with project-specific instructions

### Workflow Integration

1. **Git Hooks**: The configuration includes pre-commit hooks for code quality
2. **Automated Tasks**: Use custom commands for common development tasks
3. **MCP Servers**: Leverage MCP servers for enhanced capabilities
4. **Agent Collaboration**: Use specialized agents for complex tasks

## Available Commands

After installation, you'll have access to these custom commands:

### Task Management

- `/task` - Simple task workflow
- `/commit` - Intelligent commit workflow
- `/code-review` - Automated code review

### Development Workflows

- `/analyze` - Code analysis and insights
- `/refactor` - Code refactoring assistance
- `/debug` - Debugging support
- `/test` - Testing workflow

### Documentation

- `/doc-gen` - Documentation generation
- `/knowledge-transfer` - Knowledge sharing workflows

### Specialized Tasks

- `/security-audit` - Security analysis
- `/performance-check` - Performance optimization
- `/hotfix` - Emergency fix workflow

## Available Agents

The configuration includes specialized AI agents:

### Core Agents

- **investigator** - Expert code investigator with sequential thinking
- **code-flow-mapper** - Code flow analysis and mapping
- **planner** - Strategic planning and problem-solving

### Specialized Agents

- **security-auditor** - Security analysis and recommendations
- **performance-analyzer** - Performance optimization
- **doc-generator** - Documentation generation
- **code-reviewer** - Code review and quality assurance
- **task-router** - Intelligent task routing and management

## Troubleshooting

### Common Issues

1. **Permission Denied**

   ```bash
   # Fix script permissions
   chmod +x copy-claude-config.sh

   # Fix hook script permissions
   chmod +x .claude/hooks/*.py
   ```

2. **Python Dependencies**

   ```bash
   # Install uv if not available
   curl -LsSf https://astral.sh/uv/install.sh | sh

   # Verify Python version
   python3 --version
   ```

3. **MCP Server Issues**

   ```bash
   # Check Node.js installation
   node --version
   npm --version

   # Test MCP server installation
   npx @upstash/context7-mcp --help
   ```

4. **Configuration Not Working**

   ```bash
   # Verify file structure
   ls -la .claude/
   ls -la .claude/hooks/
   ls -la .claude/commands/
   ls -la .claude/agents/

   # Check settings files
   cat .claude/settings.json
   cat .claude/settings.local.json
   ```

### Verification Commands

```bash
# Verify installation
./copy-claude-config.sh --help

# Check configuration structure
tree .claude/ 2>/dev/null || find .claude/ -type f

# Test hook scripts
python3 .claude/hooks/task_prep_hook.py --help
```

## Advanced Configuration

### Customizing Commands

Edit files in `.claude/commands/` to customize command behavior:

```markdown
# Example: .claude/commands/custom-task.md

/task_custom

A custom task workflow for your specific needs.

## Usage

/task_custom "Your task description"

## Workflow

1. Analyze requirements
2. Create implementation plan
3. Execute with best practices
4. Verify results
```

### Customizing Agents

Modify agent configurations in `.claude/agents/`:

```markdown
# Example: .claude/agents/custom-agent.md

You are a custom agent specialized in [your domain].

## Capabilities

- Specific capability 1
- Specific capability 2

## Usage

Use this agent for [specific use cases].
```

### Adding MCP Servers

Edit `.mcp.json` to add new MCP servers:

```json
{
  "mcpServers": {
    "your-server": {
      "command": "npx",
      "args": ["-y", "your-mcp-server"],
      "env": {
        "YOUR_API_KEY": "${YOUR_API_KEY}"
      }
    }
  }
}
```

## Support and Contributing

### Getting Help

1. Check the README.md for detailed documentation
2. Review the troubleshooting section above
3. Check Anthropic's official documentation
4. Review the MCP server documentation

### Contributing

To contribute improvements to the configuration:

1. Fork the repository
2. Make your changes
3. Test thoroughly
4. Submit a pull request

### Version History

- **v1.0.0** - Initial release with comprehensive configuration
- Includes MCP servers, custom commands, and specialized agents
- Follows Anthropic's best practices for security and usability

## License

This configuration is provided under the same license as the original repository. Please check the LICENSE file for details.

---

**Note**: This configuration follows Anthropic's best practices for Claude Code setup, including security considerations, proper file permissions, and comprehensive documentation. Always review and customize the configuration for your specific project needs.
