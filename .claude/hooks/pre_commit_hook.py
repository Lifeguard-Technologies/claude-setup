#!/usr/bin/env python3
"""
Pre-commit hook that runs quality checks before allowing commits.
"""
import json
import subprocess
import sys
import re

def check_quality_gates(prompt):
    """Run quality checks if this is a commit command."""
    if not prompt.strip().startswith('/commit'):
        return True, ""
    
    checks = []
    
    # Check for console.log statements
    result = subprocess.run(['grep', '-r', 'console.log', '--include=*.js', '--include=*.vue'], 
                          capture_output=True, text=True)
    if result.stdout:
        checks.append("⚠️ Found console.log statements - remove before committing")
    
    # Check for TODO comments
    result = subprocess.run(['grep', '-r', 'TODO', '--include=*.py', '--include=*.js'], 
                          capture_output=True, text=True)
    if result.stdout:
        checks.append("📝 Found TODO comments - consider addressing or creating issues")
    
    # Check for large files
    result = subprocess.run(['find', '.', '-size', '+1M', '-not', '-path', '*/\.*'], 
                          capture_output=True, text=True)
    if result.stdout:
        checks.append("📦 Found large files - consider using Git LFS")
    
    if checks:
        return True, f"Pre-commit checks:\n" + "\n".join(checks) + "\n\nProceed with commit? (address issues or use /commit --force)"
    
    return True, ""

def main():
    try:
        input_data = json.load(sys.stdin)
        prompt = input_data.get("prompt", "")
        
        success, message = check_quality_gates(prompt)
        if message:
            print(message)
    except:
        pass
    
    sys.exit(0)

if __name__ == "__main__":
    main()