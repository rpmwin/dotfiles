# Repository Structure

## How It's Organized

This repo uses **GNU Stow** to manage dotfiles. Each top-level directory is a "stow package" — it mirrors the structure of your home directory.

```
dotfiles/
├── zsh/              →  ~/.zshrc, ~/.zshenv, ~/.zsh/*
├── tmux/             →  ~/.tmux.conf
├── nvim/             →  ~/.config/nvim/
├── git/              →  ~/.gitconfig, ~/.gitconfig-personal, ~/.gitconfig-work
├── ghostty/          →  ~/.config/ghostty/
├── ssh/              →  ~/.ssh/config
├── posh/             →  ~/.poshthemes/
├── bat/              →  ~/.config/bat/
├── btop/             →  ~/.config/btop/
├── lazygit/          →  ~/.config/lazygit/
├── yazi/             →  ~/.config/yazi/
├── mise/             →  ~/.config/mise/
├── atuin/            →  ~/.config/atuin/
│
├── install.sh        Bootstrap script (run once on new machine)
├── stow.sh           Symlink all packages (safe to re-run)
├── macos.sh          macOS system defaults (Finder, Dock, etc.)
├── Brewfile          All tools (cross-platform)
├── Brewfile.work     Work-only tools
├── Brewfile.personal Personal-only tools
│
├── scripts/          Helper scripts
│   ├── utils.sh          Shared functions (print_step, os_detect)
│   ├── symlink-check.sh  Verify all symlinks are healthy
│   └── tmux-sessionizer.sh  Fuzzy-find projects → open tmux session
│
├── hooks/            Git hooks (tracked, not in .git/)
│   └── pre-commit        shellcheck + gitleaks
│
├── docs/             You are here
│
└── .github/
    └── workflows/
        └── ci.yml    CI: stow simulate + shellcheck on macOS + Ubuntu
```

---

## How Stow Works

Stow creates **symlinks** from your home directory into this repo. When you run `./stow.sh`:

```
What's in the repo:              What gets created in ~:
dotfiles/zsh/.zshrc         →    ~/.zshrc (symlink)
dotfiles/git/.gitconfig     →    ~/.gitconfig (symlink)
dotfiles/nvim/.config/nvim/ →    ~/.config/nvim/ (symlink)
```

The actual files live in this repo. The symlinks in `~` just point here. So when you edit `~/.zshrc`, you're actually editing `dotfiles/zsh/.zshrc` — which means it's already tracked by git.

### Why the nested directories?

Stow mirrors the directory structure relative to your home. So:

- `zsh/.zshrc` → stow puts it at `~/.zshrc` (one level)
- `nvim/.config/nvim/init.lua` → stow puts it at `~/.config/nvim/init.lua` (nested)

The directory structure inside each package must match where the file lives under `~`.

---

## The zsh/ Package (Most Complex)

```
zsh/
├── .zshrc              Master file (~15 lines, just sources topic files)
├── .zshenv             Login env: $DOTFILES, PATH, EDITOR, $BREW_PREFIX
└── .zsh/
    ├── exports.zsh     History settings, shell options (setopt)
    ├── aliases.zsh     All aliases: file, git, docker, k8s, terraform, etc.
    ├── functions.zsh   Shell functions: mkcd, killport, extract, g(), etc.
    ├── completions.zsh Tab completion + keybindings
    ├── plugins.zsh     oh-my-posh, fzf, zoxide, atuin, mise, direnv init
    ├── macos.zsh       macOS-only aliases (gated with uname check)
    └── linux.zsh       Linux-only aliases (gated with uname check)
```

**Not in the repo** (gitignored):
- `~/.zsh/local.zsh` — Machine-specific secrets, overrides, work aliases. Sourced last.

### Load order

`.zshenv` runs first (login env) → `.zshrc` sources topic files in order:
1. exports → 2. completions → 3. aliases → 4. functions → 5. plugins → 6. macos/linux → 7. local.zsh

---

## What's NOT in This Repo

| File | Why |
|------|-----|
| `~/.zsh/local.zsh` | Secrets, machine-specific config. Gitignored. |
| `~/.ssh/id_*` | Private keys. Never commit these. |
| `~/.ssh/known_hosts` | Machine-specific, auto-generated. |
| `~/.zsh_history` | Shell history. Too large, too personal. |
| `.env` files | Project secrets. Use direnv or local.zsh. |

---

## Adding a New Tool Config

Say you want to track `starship` config:

```bash
# 1. Create the stow package directory
mkdir -p dotfiles/starship/.config/starship

# 2. Move your existing config into it
mv ~/.config/starship/starship.toml dotfiles/starship/.config/starship/

# 3. Stow it (creates symlink)
cd ~/dotfiles && stow starship

# 4. Verify
ls -la ~/.config/starship/starship.toml
# Should show: starship.toml -> ../../../dotfiles/starship/.config/starship/starship.toml

# 5. Commit
git add starship/ && git commit -m "add starship config"
```

`stow.sh` auto-detects new directories, so next time you run `./stow.sh`, starship will be included automatically.
