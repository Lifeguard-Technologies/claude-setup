Create a full development pipeline for a feature.

## Prerequisites

Ensure all subagent commands exist:

- /analyze (or /task_medium)
- /test
- /security-audit
- /performance-check
- /doc-gen
- /code-review
- /commit

## SEQUENCE:

1. /analyze $ARGUMENTS - Investigate and plan
2. Implement the solution following the plan
3. /test [implemented files] - Generate comprehensive tests
4. /security-audit - Check for vulnerabilities
5. /performance-check - Validate performance
6. /doc-gen - Update documentation
7. /code-review - Final code review
8. /commit - Create clean commit

Feature: $ARGUMENTS
