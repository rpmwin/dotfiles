# dotfiles

My personal dotfiles. One command sets up any machine (macOS or Linux).

## Setup

```bash
git clone git@github.com:rpmwin/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

Open a new terminal. Done.

## What's included

**Shell** — zsh with oh-my-posh, fzf, zoxide, atuin, autosuggestions, syntax highlighting

**Editor** — neovim (kickstart.nvim based) with seamless tmux navigation (Ctrl+HJKL)

**Terminal** — ghostty + tmux with sessionizer (Ctrl+F to fuzzy-find projects)

**Git** — delta for pretty diffs, lazygit for TUI, git aliases, gitleaks pre-commit hook

**Modern CLI** — bat, eza, fd, ripgrep, btop, yazi

**DevOps** — kubectl, k9s, helm, terraform, argocd, sops

**Theme** — Catppuccin Mocha everywhere

## How it works

Uses [GNU Stow](https://www.gnu.org/software/stow/) to symlink configs from this repo into `~`. Each directory is a stow package.

```
dotfiles/zsh/.zshrc  →  symlink at ~/.zshrc
dotfiles/git/.gitconfig  →  symlink at ~/.gitconfig
```

Edit files normally — they're already tracked by git.

## Quick commands

```
dots update    git pull + brew bundle + re-stow
dots edit      open dotfiles in editor
dots cd        cd to dotfiles
dots check     verify all symlinks
dots add "msg" git add + commit + push
```

## Machine-specific config

Put secrets, work aliases, custom paths in `~/.zsh/local.zsh` (gitignored).

## Docs

See [docs/](docs/) for detailed guides on setup, structure, tools, customization, and cross-platform usage.
