# Cross-Platform

This repo works on both macOS and Linux.

## How

Homebrew runs on both (called Linuxbrew on Linux). Same commands, same Brewfile. The only difference is the install path, and `.zshenv` handles that automatically:

- macOS: `/opt/homebrew/`
- Linux: `/home/linuxbrew/.linuxbrew/`

macOS-only stuff (GUI apps, fonts) is gated in Brewfile with `if OS.mac?` — silently skipped on Linux.

## OS-specific shell config

In `.zshrc`:
```bash
[[ "$(uname)" == "Darwin" ]] && source ~/.zsh/macos.zsh
[[ "$(uname)" == "Linux" ]]  && source ~/.zsh/linux.zsh
```

`macos.zsh` has things like `flushdns` and `brew update`. `linux.zsh` has `apt update` and clipboard aliases.

Add OS-specific stuff to the right file.

## Differences to know about

- Clipboard: macOS has `pbcopy`/`pbpaste` built-in. On Linux, add aliases for `xclip` or `wl-copy` in `linux.zsh`
- `open` command: built-in on macOS. On Linux, alias `open='xdg-open'`
- GUI apps (casks): only on macOS. On Linux use distro package manager
- `macos.sh` system defaults: only runs on macOS, skipped on Linux

## Testing on Linux

Quick test with Docker:
```bash
docker run -it ubuntu:latest bash
apt update && apt install -y git curl build-essential
git clone https://github.com/rpmwin/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./install.sh
```

CI also tests on both macOS and Ubuntu automatically.
