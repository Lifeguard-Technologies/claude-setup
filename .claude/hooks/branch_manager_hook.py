#!/usr/bin/env python3
"""
Automatically manage git branches based on task type.
"""
import json
import subprocess
import sys
import re

def create_branch_for_task(prompt):
    """Create appropriate branch based on task type."""
    task_patterns = {
        '/hotfix': 'hotfix/',
        '/analyze': 'feature/',
        '/refactor': 'refactor/',
        '/debug': 'fix/',
        '/fix': 'fix/'
    }
    
    for pattern, prefix in task_patterns.items():
        if prompt.strip().startswith(pattern):
            # Extract task description
            description = prompt.replace(pattern, '').strip()
            if description:
                # Create branch name
                branch_name = prefix + re.sub(r'[^a-zA-Z0-9-]', '-', description.lower())[:50]
                branch_name = re.sub(r'-+', '-', branch_name).strip('-')
                
                # Check current branch
                current = subprocess.run(['git', 'branch', '--show-current'], 
                                       capture_output=True, text=True)
                
                if current.stdout.strip() != branch_name:
                    return f"💡 Suggested branch: {branch_name}\nUse: git checkout -b {branch_name}"
    
    return ""

def main():
    try:
        input_data = json.load(sys.stdin)
        prompt = input_data.get("prompt", "")
        
        suggestion = create_branch_for_task(prompt)
        if suggestion:
            print(suggestion)
    except:
        pass
    
    sys.exit(0)

if __name__ == "__main__":
    main()