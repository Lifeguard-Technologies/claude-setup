#!/bin/bash

# Claude Configuration Copy Script
# This script copies Claude Code configuration files to another repository
# following Anthropic's best practices for configuration management.
#
# Usage: ./copy-claude-config.sh <target_repo_path>
# Example: ./copy-claude-config.sh /path/to/your/project

set -euo pipefail  # Exit on error, undefined vars, pipe failures

# Colors for output
# Colors for output
# Default to no colors for better compatibility
RED=''
GREEN=''
YELLOW=''
BLUE=''
NC=''

# Function to enable colors
enable_colors() {
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    NC='\033[0m' # No Color
}

# Script configuration
SCRIPT_NAME="copy-claude-config.sh"
VERSION="1.0.0"
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILES=(
    ".claude/"
    ".mcp.json"
    "README.md"
)

# Function to print colored output
print_status() {
    local color=$1
    local message=$2
    echo -e "${color}[$(date +'%Y-%m-%d %H:%M:%S')] ${message}${NC}"
}

# Function to print usage information
print_usage() {
    cat << EOF
${BLUE}Claude Configuration Copy Script v${VERSION}${NC}

${GREEN}Usage:${NC} $0 <target_repo_path>

${GREEN}Description:${NC}
    This script copies Claude Code configuration files to another repository
    following Anthropic's best practices for configuration management.

${GREEN}Arguments:${NC}
    target_repo_path    Path to the target repository where configuration
                       should be copied

${GREEN}Options:${NC}
    --color            Enable colored output (default is no colors for compatibility)

${GREEN}Examples:${NC}
    $0 /path/to/your/project
    $0 ../my-new-project
    $0 --color /path/to/your/project

${GREEN}What gets copied:${NC}
    - .claude/ directory (settings, hooks, commands, agents)
    - .mcp.json (MCP server configuration)
    - README.md (documentation and setup instructions)

${GREEN}Prerequisites:${NC}
    - Target directory must exist and be writable
    - Git repository (recommended for version control)
    - Python 3.8+ (for hook scripts)
    - uv package manager (for Python script execution)

${GREEN}Best Practices Applied:${NC}
    - Validates target directory exists and is writable
    - Creates backup of existing configuration (if any)
    - Sets proper file permissions for hook scripts
    - Provides detailed logging and error handling
    - Follows Anthropic's security recommendations
    - Includes post-installation verification steps

EOF
}

# Function to validate target directory
validate_target_directory() {
    local target_dir="$1"
    
    if [[ -z "$target_dir" ]]; then
        print_status $RED "Error: Target directory path is required"
        print_usage
        exit 1
    fi
    
    if [[ ! -d "$target_dir" ]]; then
        print_status $RED "Error: Target directory '$target_dir' does not exist"
        exit 1
    fi
    
    if [[ ! -w "$target_dir" ]]; then
        print_status $RED "Error: Target directory '$target_dir' is not writable"
        exit 1
    fi
    
    # Check if it's a git repository (recommended)
    if [[ ! -d "$target_dir/.git" ]]; then
        print_status $YELLOW "Warning: Target directory is not a git repository"
        print_status $YELLOW "Consider running: git init"
    fi
    
    print_status $GREEN "Target directory validation passed"
}

# Function to create backup of existing configuration
create_backup() {
    local target_dir="$1"
    local backup_dir="$target_dir/.claude-backup-$(date +%Y%m%d-%H%M%S)"
    
    if [[ -d "$target_dir/.claude" ]] || [[ -f "$target_dir/.mcp.json" ]]; then
        print_status $YELLOW "Existing Claude configuration found. Creating backup..."
        mkdir -p "$backup_dir"
        
        if [[ -d "$target_dir/.claude" ]]; then
            cp -r "$target_dir/.claude" "$backup_dir/"
            print_status $GREEN "Backed up .claude/ to $backup_dir"
        fi
        
        if [[ -f "$target_dir/.mcp.json" ]]; then
            cp "$target_dir/.mcp.json" "$backup_dir/"
            print_status $GREEN "Backed up .mcp.json to $backup_dir"
        fi
        
        print_status $GREEN "Backup completed: $backup_dir"
    fi
}

# Function to copy configuration files
copy_configuration() {
    local target_dir="$1"
    
    print_status $BLUE "Copying Claude configuration files..."
    
    for file in "${CONFIG_FILES[@]}"; do
        local source_path="$SOURCE_DIR/$file"
        local target_path="$target_dir/$file"
        
        # Special handling for README.md to avoid overwriting existing project README
        if [[ "$file" == "README.md" ]] && [[ -f "$target_dir/README.md" ]]; then
            target_path="$target_dir/CLAUDE_SETUP_README.md"
            print_status $YELLOW "Found existing README.md, copying as CLAUDE_SETUP_README.md instead"
        fi
        
        if [[ -e "$source_path" ]]; then
            if [[ -d "$source_path" ]]; then
                # Copy directory
                cp -r "$source_path" "$target_path"
                print_status $GREEN "Copied directory: $file"
            else
                # Copy file
                cp "$source_path" "$target_path"
                if [[ "$file" == "README.md" ]] && [[ "$target_path" == "$target_dir/CLAUDE_SETUP_README.md" ]]; then
                    print_status $GREEN "Copied file: README.md → CLAUDE_SETUP_README.md"
                else
                    print_status $GREEN "Copied file: $file"
                fi
            fi
        else
            print_status $YELLOW "Warning: Source file/directory not found: $file"
        fi
    done
}

# Function to set proper permissions
set_permissions() {
    local target_dir="$1"
    
    print_status $BLUE "Setting proper file permissions..."
    
    # Set executable permissions for Python hook scripts
    if [[ -d "$target_dir/.claude/hooks" ]]; then
        find "$target_dir/.claude/hooks" -name "*.py" -type f -exec chmod +x {} \;
        print_status $GREEN "Set executable permissions for hook scripts"
    fi
    
    # Ensure .claude directory has proper permissions
    chmod 755 "$target_dir/.claude"
    print_status $GREEN "Set directory permissions for .claude"
}

# Function to verify installation
verify_installation() {
    local target_dir="$1"
    
    print_status $BLUE "Verifying installation..."
    
    local verification_passed=true
    
    # Check if key files exist
    local required_files=(
        ".claude/settings.json"
        ".claude/settings.local.json"
        ".mcp.json"
    )
    
    for file in "${required_files[@]}"; do
        if [[ -e "$target_dir/$file" ]]; then
            print_status $GREEN "✓ Found: $file"
        else
            print_status $RED "✗ Missing: $file"
            verification_passed=false
        fi
    done
    
    # Check if directories exist
    local required_dirs=(
        ".claude/hooks"
        ".claude/commands"
        ".claude/agents"
    )
    
    for dir in "${required_dirs[@]}"; do
        if [[ -d "$target_dir/$dir" ]]; then
            print_status $GREEN "✓ Found directory: $dir"
        else
            print_status $RED "✗ Missing directory: $dir"
            verification_passed=false
        fi
    done
    
    # Check hook script permissions
    if [[ -d "$target_dir/.claude/hooks" ]]; then
        local hook_scripts=$(find "$target_dir/.claude/hooks" -name "*.py" -type f)
        for script in $hook_scripts; do
            if [[ -x "$script" ]]; then
                print_status $GREEN "✓ Executable: $(basename "$script")"
            else
                print_status $RED "✗ Not executable: $(basename "$script")"
                verification_passed=false
            fi
        done
    fi
    
    if [[ "$verification_passed" == "true" ]]; then
        print_status $GREEN "Installation verification completed successfully!"
    else
        print_status $RED "Installation verification failed. Please check the errors above."
        exit 1
    fi
}

# Function to display post-installation instructions
display_post_install_instructions() {
    local target_dir="$1"
    
    # Determine which README file to reference
    local readme_file="README.md"
    if [[ -f "$target_dir/CLAUDE_SETUP_README.md" ]]; then
        readme_file="CLAUDE_SETUP_README.md"
    fi
    
    cat << EOF

${GREEN}🎉 Claude Configuration Successfully Installed!${NC}

${BLUE}Next Steps:${NC}

1. ${YELLOW}Navigate to your project:${NC}
   cd "$target_dir"

2. ${YELLOW}Install dependencies (if not already installed):${NC}
   # Install uv (Python package manager)
   curl -LsSf https://astral.sh/uv/install.sh | sh
   
   # Verify installation
   uv --version

3. ${YELLOW}Configure environment variables (if needed):${NC}
   # Edit .claude/settings.local.json for project-specific settings
   # Set up any required API keys in your environment

4. ${YELLOW}Test the configuration:${NC}
   # Try a simple command in Claude Code
   /task_easy "Hello World"

5. ${YELLOW}Review and customize:${NC}
   # Check .claude/settings.json for permissions
   # Review .mcp.json for MCP server configuration
   # Customize commands in .claude/commands/
   # Modify agents in .claude/agents/

${BLUE}Important Notes:${NC}
- The configuration includes MCP servers for enhanced capabilities
- Hook scripts will run automatically for certain commands
- Custom commands are available for various development tasks
- Security permissions are configured to follow best practices

${BLUE}Documentation:${NC}
- See ${readme_file} for detailed Claude setup instructions
- Check .claude/commands/ for available custom commands
- Review .claude/agents/ for specialized AI agents

${GREEN}Happy coding with Claude! 🚀${NC}

EOF
}

# Main execution function
main() {
    local target_dir="$1"
    
    print_status $BLUE "Starting Claude Configuration Copy Script v${VERSION}"
    print_status $BLUE "Source directory: $SOURCE_DIR"
    print_status $BLUE "Target directory: $target_dir"
    echo
    
    # Validate target directory
    validate_target_directory "$target_dir"
    
    # Create backup if needed
    create_backup "$target_dir"
    
    # Copy configuration files
    copy_configuration "$target_dir"
    
    # Set proper permissions
    set_permissions "$target_dir"
    
    # Verify installation
    verify_installation "$target_dir"
    
    # Display post-installation instructions
    display_post_install_instructions "$target_dir"
    
    print_status $GREEN "Configuration copy completed successfully!"
}

# Check if help is requested
if [[ $# -eq 0 ]] || [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    print_usage
    exit 0
fi

# Check if version is requested
if [[ "$1" == "-v" ]] || [[ "$1" == "--version" ]]; then
    echo "Claude Configuration Copy Script v${VERSION}"
    exit 0
fi

# Check if color options are requested
if [[ "$1" == "--color" ]]; then
    enable_colors
    # Remove the --color argument and continue with the rest
    shift
fi

# Execute main function with provided target directory
main "$1" 