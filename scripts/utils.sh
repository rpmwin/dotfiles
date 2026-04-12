#!/bin/bash
# Shared helpers for dotfiles scripts

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print a step header
print_step() {
  echo -e "${BLUE}==> $1${NC}"
}

# Print success
print_ok() {
  echo -e "${GREEN}  ✓ $1${NC}"
}

# Print warning
print_warn() {
  echo -e "${YELLOW}  ! $1${NC}"
}

# Print error
print_err() {
  echo -e "${RED}  ✗ $1${NC}"
}

# Detect OS — returns "macos" or "linux"
os_detect() {
  case "$(uname)" in
    Darwin) echo "macos" ;;
    Linux)  echo "linux" ;;
    *)      echo "unknown" ;;
  esac
}

# Check if a command exists
check_cmd() {
  command -v "$1" &>/dev/null
}
