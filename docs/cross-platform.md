# Cross-Platform Guide

This dotfiles repo works on both **macOS** and **Linux**. Here's how.

---

## The Big Picture

```
                    ┌─────────────────────────┐
                    │      install.sh          │
                    │  (detects OS, runs all)  │
                    └────────────┬─────────────┘
                                 │
                    ┌────────────┴────────────┐
                    │                         │
              ┌─────┴─────┐           ┌──────┴──────┐
              │   macOS    │           │    Linux    │
              │            │           │             │
              │ /opt/      │           │ /home/      │
              │ homebrew/  │           │ linuxbrew/  │
              │            │           │ .linuxbrew/ │
              └─────┬──────┘           └──────┬──────┘
                    │                         │
                    └────────────┬─────────────┘
                                 │
                    ┌────────────┴─────────────┐
                    │   Same Brewfile          │
                    │   Same stow packages     │
                    │   Same shell config      │
                    └──────────────────────────┘
```

---

## How It Works

### Homebrew Everywhere

Homebrew works on both macOS and Linux (called Linuxbrew on Linux). Same commands, same formula names, same Brewfile.

The only difference is the install path:
- **macOS**: `/opt/homebrew/` (Apple Silicon) or `/usr/local/` (Intel)
- **Linux**: `/home/linuxbrew/.linuxbrew/`

This is handled automatically in `.zshenv`:

```bash
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
```

### macOS-Only Casks

Some things only exist on macOS (GUI apps, fonts). These are gated in the Brewfile:

```ruby
cask "font-jetbrains-mono" if OS.mac?
cask "ghostty" if OS.mac?
cask "gcloud-cli" if OS.mac?
```

On Linux, these lines are silently skipped.

---

## OS-Specific Shell Config

### How it's gated

In `.zshrc`:
```bash
[[ "$(uname)" == "Darwin" ]] && source ~/.zsh/macos.zsh
[[ "$(uname)" == "Linux" ]]  && source ~/.zsh/linux.zsh
```

### macOS-only things (macos.zsh)

```bash
alias update='brew update && brew upgrade'
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
```

### Linux-only things (linux.zsh)

```bash
alias update='sudo apt update && sudo apt upgrade -y'
```

Add more OS-specific aliases/functions to these files as needed.

---

## What Differs Between macOS and Linux

| Thing | macOS | Linux |
|-------|-------|-------|
| Homebrew path | `/opt/homebrew/` | `/home/linuxbrew/.linuxbrew/` |
| GUI apps (casks) | Available | Not available (use distro package manager) |
| `macos.sh` defaults | Runs | Skipped |
| `flushdns` alias | Works | Not available (different on each distro) |
| Clipboard | `pbcopy` / `pbpaste` | `xclip` or `wl-copy` |
| `open` command | Built-in | Use `xdg-open` |
| Font install | Via cask | Via distro package manager |

### Handling clipboard differences

Add this to your `macos.zsh` and `linux.zsh`:

**macos.zsh** — `pbcopy`/`pbpaste` work natively, nothing to do.

**linux.zsh**:
```bash
# Clipboard (X11)
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# Or for Wayland:
# alias pbcopy='wl-copy'
# alias pbpaste='wl-paste'

# open command
alias open='xdg-open'
```

---

## Testing on Linux

### Using Docker

Quick way to test your dotfiles on Linux without a real machine:

```bash
docker run -it ubuntu:latest bash
# Then inside the container:
apt update && apt install -y git curl build-essential
git clone https://github.com/rpmwin/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./install.sh
```

### Using a VM

For full testing (including GUI tools), use a VM with Ubuntu or Fedora.

### Using GitHub Actions CI

The CI pipeline tests on both macOS and Ubuntu automatically. Every push verifies that `stow --simulate` and `shellcheck` pass on both platforms.

---

## Adding Platform-Specific Config

If a tool behaves differently on macOS vs Linux:

1. **Shell aliases/config**: Add to `macos.zsh` or `linux.zsh`
2. **Brewfile packages**: Use `if OS.mac?` or `if OS.linux?` guards
3. **install.sh steps**: Gate with `[[ "$OS" == "Darwin" ]]` or `[[ "$OS" == "Linux" ]]`
4. **Separate config files**: If a tool needs completely different config per OS, use a conditional symlink or `local.zsh`
