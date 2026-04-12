#!/bin/bash
# Day-0 bootstrap — cross-platform, idempotent
# Usage: git clone <repo> ~/dotfiles && cd ~/dotfiles && ./install.sh
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
OS="$(uname)"

echo "==> Dotfiles bootstrap ($OS)"

# ----------------------------------------------------------
# 1. Install Homebrew
# ----------------------------------------------------------
if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add brew to PATH for this session
  if [[ "$OS" == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
else
  echo "==> Homebrew already installed"
fi

# ----------------------------------------------------------
# 2. Install packages
# ----------------------------------------------------------
echo "==> Installing packages from Brewfile..."
brew bundle --file="$DOTFILES/Brewfile"

# Optional: work/personal bundles
if [[ -f "$DOTFILES/Brewfile.work" ]]; then
  read -p "Install work packages? [y/N] " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]] && brew bundle --file="$DOTFILES/Brewfile.work"
fi

if [[ -f "$DOTFILES/Brewfile.personal" ]]; then
  read -p "Install personal packages? [y/N] " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]] && brew bundle --file="$DOTFILES/Brewfile.personal"
fi

# ----------------------------------------------------------
# 3. Backup existing configs
# ----------------------------------------------------------
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"
echo "==> Backing up existing configs to $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# Backup files that stow will replace
for f in .zshrc .zshenv .tmux.conf .gitconfig; do
  [[ -f "$HOME/$f" && ! -L "$HOME/$f" ]] && cp "$HOME/$f" "$BACKUP_DIR/"
done
for d in .config/nvim .config/ghostty .ssh; do
  [[ -d "$HOME/$d" && ! -L "$HOME/$d" ]] && cp -r "$HOME/$d" "$BACKUP_DIR/"
done

# ----------------------------------------------------------
# 4. Stow all packages
# ----------------------------------------------------------
echo "==> Stowing dotfiles..."
"$DOTFILES/stow.sh" --adopt

# Review adopted changes
if [[ -n "$(git -C "$DOTFILES" diff)" ]]; then
  echo "==> stow --adopt pulled in changes. Review with: cd $DOTFILES && git diff"
fi

# ----------------------------------------------------------
# 5. macOS defaults
# ----------------------------------------------------------
if [[ "$OS" == "Darwin" && -f "$DOTFILES/macos.sh" ]]; then
  read -p "Apply macOS defaults? [y/N] " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]] && bash "$DOTFILES/macos.sh"
fi

# ----------------------------------------------------------
# 6. tmux plugin manager
# ----------------------------------------------------------
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [[ ! -d "$TPM_DIR" ]]; then
  echo "==> Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
  echo "==> TPM already installed"
fi

# ----------------------------------------------------------
# 7. Neovim plugins (headless)
# ----------------------------------------------------------
if command -v nvim &>/dev/null; then
  echo "==> Installing nvim plugins..."
  nvim --headless "+Lazy! sync" +qa 2>/dev/null || echo "  (plugins will install on next nvim open)"
fi

# ----------------------------------------------------------
# 8. Git hooks
# ----------------------------------------------------------
echo "==> Setting git hooks path..."
git -C "$DOTFILES" config core.hooksPath hooks/

# ----------------------------------------------------------
# Done
# ----------------------------------------------------------
echo ""
echo "==> Bootstrap complete!"
echo "    Open a new terminal to load the config."
echo "    Machine-specific overrides: ~/.zsh/local.zsh"
