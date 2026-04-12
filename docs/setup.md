# Setup Guide

## New Machine? Three commands:

```bash
git clone git@github.com:rpmwin/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

Open a new terminal. Done.

## What install.sh does

1. Installs Homebrew (works on macOS and Linux, skips if already installed)
2. Installs all tools from Brewfile
3. Asks if you want work packages (k8s, terraform, etc.)
4. Asks if you want personal packages
5. Backs up your existing configs to `~/.dotfiles-backup/<timestamp>/`
6. Runs stow to create all symlinks
7. On macOS, asks if you want to apply system defaults (Finder, Dock, keyboard)
8. Installs tmux plugin manager
9. Installs neovim plugins
10. Sets up git hooks (shellcheck + gitleaks)

## After setup

Create a file for machine-specific stuff (secrets, work aliases, custom paths):

```bash
touch ~/.zsh/local.zsh
```

This file is gitignored and sourced last, so it can override anything. Example:

```bash
export PROJECTS="$HOME/work/repos"
alias awslogin='aws sso login --sso-session work'
```

## Updating

```bash
cd ~/dotfiles
git pull
brew bundle
./stow.sh
```

## If something breaks

**Stow says "cannot stow X over existing target"** — A real file is in the way. Either adopt it (`stow --adopt <package>`) or delete the file in `~` and re-run `./stow.sh`.

**Shell looks weird** — Open a new terminal tab. Old tab still has old config loaded.

**Check symlinks are correct:**
```bash
ls -la ~/.zshrc
# Should show: .zshrc -> dotfiles/zsh/.zshrc
```

**Restore from backup:**
```bash
ls ~/.dotfiles-backup/
cp ~/.dotfiles-backup/<timestamp>/.zshrc ~/
```
