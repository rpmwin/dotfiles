---
glob: /Users/iamrpm/dotfiles/**
---

# Dotfiles Context

Personal dotfiles managed with GNU Stow. Shell config, tool configs, scripts.

## Directory Layout

```
~/dotfiles/
├── zsh/        # zsh config — symlinked to ~/.zsh/
├── nvim/       # Neovim config
├── tmux/       # tmux config
├── git/        # git config and hooks
├── mise/       # mise (tool version manager) config
├── scripts/    # utility scripts
└── ssh/        # SSH config (no private keys)
```

## Directives

- MUST test shell changes by reloading (`source ~/.zshrc`) before declaring done.
- MUST NOT break existing symlinks — Stow manages the link structure.
- MUST check if a function/alias already exists before adding a new one.
- MUST keep functions in `zsh/.zsh/functions.zsh` and aliases in `zsh/.zsh/aliases.zsh`.
- MUST NOT commit secrets or private keys.
- SHOULD prefer POSIX-compatible shell syntax unless zsh-specific features are intentional.
