# Repo Structure

## How it works

Each top-level directory is a "stow package." Stow creates symlinks from your home directory pointing into this repo.

Example: the file `dotfiles/zsh/.zshrc` becomes a symlink at `~/.zshrc`. So editing `~/.zshrc` actually edits the file in this repo — already tracked by git.

## Directories

**Config packages** (each one gets symlinked into ~):
- `zsh/` — shell config (.zshrc, .zshenv, topic files)
- `tmux/` — tmux config
- `nvim/` — neovim config
- `git/` — gitconfig, gitconfig-personal, gitconfig-work
- `ghostty/` — terminal config
- `ssh/` — ssh config (no keys!)
- `posh/` — oh-my-posh theme
- `bat/` — bat config
- `btop/` — btop config
- `lazygit/` — lazygit config
- `yazi/` — yazi file manager config
- `mise/` — language version manager config
- `atuin/` — shell history config

**Not stow packages** (scripts, docs, CI):
- `scripts/` — helper scripts (tmux-sessionizer, symlink checker)
- `hooks/` — git pre-commit hook
- `docs/` — documentation
- `.github/` — CI workflows

**Root files:**
- `install.sh` — run once on new machine
- `stow.sh` — symlink all packages (safe to re-run)
- `macos.sh` — macOS system defaults
- `Brewfile` — all tools
- `Brewfile.work` / `Brewfile.personal` — optional tool bundles

## The zsh package

This is the most complex one. The old monolithic `.zshrc` is split into small files:

- `.zshrc` — master file, just sources the topic files below
- `.zshenv` — sets $DOTFILES, PATH, EDITOR, $BREW_PREFIX
- `.zsh/exports.zsh` — history settings, shell options
- `.zsh/aliases.zsh` — all aliases (git, docker, k8s, etc.)
- `.zsh/functions.zsh` — shell functions (mkcd, extract, g(), etc.)
- `.zsh/completions.zsh` — tab completion and keybindings
- `.zsh/plugins.zsh` — oh-my-posh, fzf, zoxide, atuin, mise, direnv
- `.zsh/macos.zsh` — macOS-only stuff
- `.zsh/linux.zsh` — Linux-only stuff
- `.zsh/local.zsh` — your secrets and overrides (gitignored, not in repo)

Load order: .zshenv first, then .zshrc sources everything in order, local.zsh last.

## What's NOT in this repo

- `~/.zsh/local.zsh` — secrets, machine-specific config
- `~/.ssh/id_*` — private keys (never commit these)
- `~/.ssh/known_hosts` — auto-generated
- `~/.zsh_history` — too large, too personal
- `.env` files — project secrets
