# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Bootstrap & Setup

```bash
# Full setup on a new machine
./install.sh

# Re-stow all packages (safe to re-run)
./stow.sh

# First-time stow (adopt existing files into repo)
./stow.sh --adopt
```

After `--adopt`, run `git diff` — stow may have pulled in local changes that differ from the repo.

## Day-to-day Commands

```bash
dots update    # git pull + brew bundle + re-stow
dots check     # verify all symlinks point into dotfiles
dots add "msg" # git add -A + commit + push
dots edit      # open dotfiles in $EDITOR
```

## How Stow Works

Each top-level directory (except `scripts/`, `hooks/`, `docs/`, `.github/`, `.claude/`) is a stow package. Stow symlinks its contents into `$HOME`, preserving directory structure:

```
dotfiles/zsh/.zshrc       →  ~/.zshrc
dotfiles/git/.gitconfig   →  ~/.gitconfig
dotfiles/nvim/.config/nvim/  →  ~/.config/nvim/
```

Editing files in `~` edits them in the repo directly — they're already symlinks.

## zsh Config Architecture

`.zshrc` is a thin sourcer. Load order:

1. `.zshenv` — sets `$DOTFILES`, `$BREW_PREFIX`, `$PATH`, `$EDITOR`
2. `.zsh/exports.zsh` — history, shell options
3. `.zsh/completions.zsh` — tab completion, keybindings
4. `.zsh/aliases.zsh` — all aliases
5. `.zsh/functions.zsh` — shell functions (`dots`, `g`, `tt`, etc.)
6. `.zsh/plugins.zsh` — oh-my-posh, fzf, zoxide, atuin, mise, direnv
7. `.zsh/macos.zsh` or `.zsh/linux.zsh` — OS-gated
8. `~/.zsh/local.zsh` — machine-local overrides, secrets (gitignored, not in repo)

New aliases → `aliases.zsh`. New functions → `functions.zsh`. OS-specific → the right platform file.

## Cross-Platform

Both macOS and Linux are supported. `$BREW_PREFIX` is set in `.zshenv` and differs by OS. Brewfile uses `if OS.mac?` guards for macOS-only casks. Shell config uses `uname` guards to source the right platform file.

## Git Config

Conditional includes split work vs personal identity:

```
~/.gitconfig → includes ~/.gitconfig-work or ~/.gitconfig-personal based on directory path
```

## Pre-commit Hooks

Activated via `git config core.hooksPath hooks/` (run by `install.sh`). Hooks run:
- `shellcheck` on staged `.sh`/`.bash` files
- `gitleaks protect --staged` to block secret commits

## CI

GitHub Actions runs on `macos-latest` and `ubuntu-latest`:
- Stow dry-run (`--simulate`) for all packages
- `shellcheck` on `install.sh`, `stow.sh`, `macos.sh`, `scripts/*.sh`
