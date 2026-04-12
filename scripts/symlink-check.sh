#!/bin/bash
# Verify all stow symlinks are healthy
# Usage: ./scripts/symlink-check.sh

source "$(dirname "$0")/utils.sh"

DOTFILES="${DOTFILES:-$HOME/dotfiles}"
errors=0

print_step "Checking symlinks..."

# Expected symlinks: file_in_repo → target_in_home
check_link() {
  local target="$1"
  local expected="$2"

  if [[ -L "$target" ]]; then
    actual=$(readlink "$target")
    if [[ "$actual" == *"$expected"* ]]; then
      print_ok "$target"
    else
      print_err "$target → $actual (expected *$expected*)"
      ((errors++))
    fi
  elif [[ -e "$target" ]]; then
    print_warn "$target exists but is NOT a symlink"
    ((errors++))
  else
    print_warn "$target missing"
    ((errors++))
  fi
}

# Core configs
check_link "$HOME/.zshrc" "dotfiles/zsh/.zshrc"
check_link "$HOME/.zshenv" "dotfiles/zsh/.zshenv"
check_link "$HOME/.tmux.conf" "dotfiles/tmux/.tmux.conf"
check_link "$HOME/.gitconfig" "dotfiles/git/.gitconfig"
check_link "$HOME/.gitignore_global" "dotfiles/git/.gitignore_global"

# .config symlinks
check_link "$HOME/.config/nvim" "dotfiles/nvim/.config/nvim"
check_link "$HOME/.config/ghostty" "dotfiles/ghostty/.config/ghostty"
check_link "$HOME/.config/bat" "dotfiles/bat/.config/bat"
check_link "$HOME/.config/btop" "dotfiles/btop/.config/btop"
check_link "$HOME/.config/lazygit" "dotfiles/lazygit/.config/lazygit"
check_link "$HOME/.config/yazi" "dotfiles/yazi/.config/yazi"
check_link "$HOME/.config/mise" "dotfiles/mise/.config/mise"
check_link "$HOME/.config/atuin" "dotfiles/atuin/.config/atuin"

# Other
check_link "$HOME/.ssh/config" "dotfiles/ssh/.ssh/config"
check_link "$HOME/.poshthemes" "dotfiles/posh/.poshthemes"

echo ""
if [[ $errors -eq 0 ]]; then
  print_ok "All symlinks healthy!"
else
  print_err "$errors issue(s) found. Run ./stow.sh to fix."
fi
