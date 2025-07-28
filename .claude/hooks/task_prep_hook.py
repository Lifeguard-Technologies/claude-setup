#!/usr/bin/env python3
"""
UserPromptSubmit hook for task directory preparation.
Automatically creates claude-instance-{id} directories when users type /task or /analyze.
Works with the task-router agent to determine if directory creation is needed.
"""
import json
import os
import sys
import re
from pathlib import Path


def get_next_instance_id(base_dir: Path) -> int:
    """Find the next available instance ID by checking existing directories."""
    if not base_dir.exists():
        return 1
    
    existing_dirs = [
        d for d in base_dir.iterdir() 
        if d.is_dir() and d.name.startswith('claude-instance-')
    ]
    
    if not existing_dirs:
        return 1
    
    # Extract numbers from directory names
    numbers = []
    for dir_path in existing_dirs:
        match = re.search(r'claude-instance-(\d+)', dir_path.name)
        if match:
            numbers.append(int(match.group(1)))
    
    return max(numbers) + 1 if numbers else 1


def create_instance_directory(cwd: str, instance_id: int) -> tuple[bool, str]:
    """Create the claude-instance directory and return success status and path."""
    try:
        base_dir = Path(cwd) / "claude-code-storage"
        instance_dir = base_dir / f"claude-instance-{instance_id}"
        
        # Create directories with proper permissions
        base_dir.mkdir(exist_ok=True)
        instance_dir.mkdir(exist_ok=True)
        
        return True, str(instance_dir)
    except Exception as e:
        return False, str(e)


def validate_prompt(prompt: str) -> tuple[bool, str]:
    """
    Check if prompt requires directory setup.
    Returns (needs_directory, command_type)
    """
    cleaned_prompt = prompt.strip()
    
    # Check for commands that might need investigation workflow
    # /analyze always needs it
    if cleaned_prompt.startswith('/analyze'):
        return True, 'analyze'
    
    # /task might need it depending on task-router decision
    # For now, we'll create it preemptively for /task commands
    # The task-router will decide if it's actually used
    if cleaned_prompt.startswith('/task'):
        return True, 'task'
    
    # Legacy support for /task_medium
    if cleaned_prompt.startswith('/task_medium'):
        return True, 'task_medium'
    
    return False, ''


def extract_problem_text(prompt: str, command: str) -> str:
    """Extract the problem description from the prompt."""
    # Remove the command part to get the problem description
    patterns = [f'/{command}', f'/{command}_medium']
    
    problem_text = prompt
    for pattern in patterns:
        problem_text = problem_text.replace(pattern, '', 1)
    
    return problem_text.strip()


def main():
    """Main hook execution logic."""
    try:
        # Read JSON input from stdin
        input_data = json.load(sys.stdin)
    except json.JSONDecodeError as e:
        # Not a JSON input, exit silently
        sys.exit(0)
    
    # Extract required fields
    prompt = input_data.get("prompt", "")
    cwd = input_data.get("cwd", os.getcwd())
    
    # Check if this prompt needs directory setup
    needs_directory, command_type = validate_prompt(prompt)
    
    if not needs_directory:
        # Not a relevant prompt, exit silently to allow normal processing
        sys.exit(0)
    
    # Get next instance ID
    base_dir = Path(cwd) / "claude-code-storage"
    instance_id = get_next_instance_id(base_dir)
    
    # Create instance directory
    success, result = create_instance_directory(cwd, instance_id)
    
    if success:
        # Extract the original problem from the prompt
        problem_text = extract_problem_text(prompt, command_type)
        
        # Build context message based on command type
        if command_type == 'analyze':
            # For /analyze, we know it will use the full investigation workflow
            context_msg = (
                f"Directory claude-instance-{instance_id} has been automatically created for this analysis session. "
                f"The investigator, code-flow-mapper, and planner agents will create their reports "
                f"(INVESTIGATION_REPORT.md, FLOW_REPORT.md, and PLAN.md) inside claude-code-storage/claude-instance-{instance_id}/."
            )
        elif command_type == 'task':
            # For /task, the task-router will decide the workflow
            context_msg = (
                f"Directory claude-instance-{instance_id} has been prepared for this task session. "
                f"The task-router will analyze the complexity and determine the appropriate workflow. "
                f"If complex analysis is needed, reports will be saved to claude-code-storage/claude-instance-{instance_id}/."
            )
        else:
            # Legacy /task_medium support
            context_msg = (
                f"Directory claude-instance-{instance_id} has been automatically created for this task session. "
                f"The subagents must create the INVESTIGATION_REPORT.md, FLOW_REPORT.md and PLAN.md files "
                f"inside claude-code-storage/claude-instance-{instance_id}/."
            )
        
        if problem_text:
            context_msg += f"\n\nProblem to solve: {problem_text}"
        
        # Add instance path for easy reference
        context_msg += f"\n\nInstance path: {result}"
        
        print(context_msg)
        sys.exit(0)
    else:
        # Output error but don't block processing
        print(f"Warning: Failed to create instance directory: {result}", file=sys.stderr)
        sys.exit(0)


if __name__ == "__main__":
    main()