#!/bin/bash
# Stow all packages — auto-detects, cross-platform, idempotent

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
cd "$DOTFILES"

# First run: --adopt moves real files into repo + creates symlinks
# After first run: normal stow (no --adopt)
ADOPT=""
[[ "$1" == "--adopt" ]] && ADOPT="--adopt"

# Auto-detect: any dir with dotfiles (not scripts/hooks/docs/.github)
skip=(scripts hooks docs .github .git .claude)

for dir in */; do
  pkg="${dir%/}"

  # Skip non-stow dirs
  [[ " ${skip[*]} " =~ " ${pkg} " ]] && continue

  echo "Stowing $pkg..."
  stow -v $ADOPT --target="$HOME" "$pkg"
done

echo "All packages stowed."
