#!/bin/bash

# Example Usage Script for Claude Configuration Copy
# This script demonstrates how to use the copy-claude-config.sh script

set -euo pipefail

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}Claude Configuration Copy - Example Usage${NC}"
echo "================================================"
echo

# Create a test directory
TEST_DIR="./test-claude-config"
echo -e "${YELLOW}Creating test directory: $TEST_DIR${NC}"
mkdir -p "$TEST_DIR"

# Initialize git repository in test directory
echo -e "${YELLOW}Initializing git repository...${NC}"
cd "$TEST_DIR"
git init
cd ..

# Run the copy script
echo -e "${YELLOW}Running copy script...${NC}"
./copy-claude-config.sh "$TEST_DIR"

echo
echo -e "${GREEN}Example completed!${NC}"
echo -e "${BLUE}You can now explore the copied configuration in: $TEST_DIR${NC}"
echo
echo -e "${YELLOW}To clean up the test directory, run:${NC}"
echo "rm -rf $TEST_DIR" 