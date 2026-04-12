# Setup Guide

## Quick Start (New Machine)

You need just **one command** to get everything running on a fresh machine:

```bash
git clone git@github.com:rpmwin/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

That's it. Open a new terminal and everything is ready.

---

## What install.sh Does (Step by Step)

1. **Installs Homebrew** — Works on both macOS and Linux. If Homebrew is already installed, it skips this step.

2. **Installs all your tools** — Runs `brew bundle` with the `Brewfile`. This installs everything: shell tools, CLI utilities, dev tools, DevOps tools, fonts.

3. **Asks about work/personal packages** — You'll be prompted:
   - "Install work packages?" → Adds k8s, terraform, sops, gcloud, etc.
   - "Install personal packages?" → Adds personal apps like maccy.

4. **Backs up your existing configs** — Before overwriting anything, it copies your current dotfiles to `~/.dotfiles-backup/<timestamp>/`. If something goes wrong, your old configs are safe.

5. **Creates symlinks with GNU Stow** — Runs `stow.sh --adopt`. This is the core magic:
   - Every config file in this repo gets symlinked to the right place in your home directory.
   - Example: `dotfiles/zsh/.zshrc` → symlink at `~/.zshrc`
   - If you already have real files (not symlinks), `--adopt` moves them into the repo and creates the symlink.

6. **Applies macOS defaults** (macOS only) — Asks before applying. Sets up Finder, Dock, keyboard repeat speed, trackpad tap-to-click, screenshot settings, etc.

7. **Installs tmux plugin manager (TPM)** — Clones TPM so tmux plugins work on first launch.

8. **Installs Neovim plugins** — Runs `Lazy sync` headlessly. If it fails (no network), plugins install on next manual nvim open.

9. **Sets git hooks path** — Points git to `hooks/` directory so the pre-commit hook (shellcheck + gitleaks) is always active.

---

## After Setup

### Machine-Specific Config

Every machine is different. For things like work credentials, custom paths, or secrets:

```bash
# Create your local overrides file (this is gitignored)
touch ~/.zsh/local.zsh
```

Put anything machine-specific in there. Examples:

```bash
# Work proxy
export HTTP_PROXY="http://proxy.work.com:8080"

# Custom project directory
export PROJECTS="$HOME/work/repos"

# Work-specific aliases
alias awslogin='aws sso login --sso-session work'
```

This file is sourced last in `.zshrc`, so it can override anything.

### Updating

After you pull new changes:

```bash
cd ~/dotfiles
git pull
brew bundle          # install any new tools
./stow.sh            # re-link any new configs
```

Or use the `dots update` command (once the dots CLI is set up).

---

## Troubleshooting

### Stow says "cannot stow X over existing target"

This means a real file exists where the symlink should go. Two options:

1. **Adopt it**: `stow --adopt -v --target=$HOME <package>` — moves the real file into the repo, creates symlink. Then `git diff` to review what changed.

2. **Delete it**: If you're sure the repo version is correct, delete the file in `~` and re-run `./stow.sh`.

### Shell looks broken after setup

Open a new terminal tab/window. The old one still has the old shell session loaded.

If still broken, check:
```bash
# Is .zshrc a symlink?
ls -la ~/.zshrc
# Should show: .zshrc -> dotfiles/zsh/.zshrc

# Are topic files present?
ls ~/.zsh/
# Should show: aliases.zsh, exports.zsh, functions.zsh, etc.
```

### Homebrew not found (Linux)

Make sure Linuxbrew is in your PATH. The `.zshenv` handles this automatically, but if you're using bash:

```bash
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

### Restoring from backup

If something went wrong:

```bash
ls ~/.dotfiles-backup/
# Find the latest timestamp directory
cp -r ~/.dotfiles-backup/<timestamp>/.zshrc ~/
# Repeat for any other files you need to restore
```
