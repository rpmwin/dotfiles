# Customization

## Machine-specific stuff (local.zsh)

Create `~/.zsh/local.zsh` for anything that shouldn't be in git:

```bash
touch ~/.zsh/local.zsh
```

It's gitignored, sourced last (can override anything), and optional (nothing breaks if it's missing).

Put work credentials, custom paths, proxies, etc. here:

```bash
export PROJECTS="$HOME/work/repos"
alias awslogin='aws sso login --sso-session work'
export HTTP_PROXY="http://proxy.corp.com:8080"
```

## Adding a new tool config

Say you want to track starship config:

```bash
# Create the directory (must mirror where it lives in ~)
mkdir -p ~/dotfiles/starship/.config/starship

# Move your config in
mv ~/.config/starship/starship.toml ~/dotfiles/starship/.config/starship/

# Stow it (or just run ./stow.sh — it auto-detects new dirs)
cd ~/dotfiles && stow starship

# Commit
git add starship/ && git commit -m "add starship config"
```

## Adding aliases

Edit `zsh/.zsh/aliases.zsh`, add under a comment header:

```bash
# Ansible
alias ap='ansible-playbook'
alias av='ansible-vault'
```

Reload with `rz`.

## Adding shell functions

Edit `zsh/.zsh/functions.zsh`:

```bash
ksh() {
  pod=$(kubectl get pods | grep "$1" | head -1 | awk '{print $1}')
  kubectl exec -it "$pod" -- /bin/sh
}
```

## Adding a new brew tool

1. Add to `Brewfile`: `brew "glow"`
2. Install: `brew bundle --file=~/dotfiles/Brewfile`
3. If it has config files → create stow package:
   ```bash
   mkdir -p ~/dotfiles/glow/.config/glow
   mv ~/.config/glow/glow.yml ~/dotfiles/glow/.config/glow/
   cd ~/dotfiles && stow glow
   ```
4. If it needs shell init → add to `plugins.zsh`:
   ```bash
   command -v newtool &>/dev/null && eval "$(newtool init zsh)"
   ```
5. If you want an alias → add to `aliases.zsh`
6. Commit: `cd ~/dotfiles && git add -A && git commit -m "add glow"`

Skip steps 3-5 if they don't apply. Most tools only need steps 1, 2, 6.

### Handy brew bundle commands

```bash
brew bundle cleanup          # show installed but not in Brewfile
brew bundle cleanup --force  # uninstall those orphans
brew bundle check            # verify all Brewfile packages installed
brew bundle dump             # generate Brewfile from current machine
```

## Changing the theme

Everything uses Catppuccin Mocha. To switch flavors, update the theme in each tool's config file:
- oh-my-posh: `posh/.poshthemes/`
- bat: `bat/.config/bat/config`
- btop: `btop/.config/btop/btop.conf`
- lazygit: `lazygit/.config/lazygit/config.yml`
- yazi: `yazi/.config/yazi/theme.toml`
- delta: `git/.gitconfig` under `[delta]`
- nvim: colorscheme in nvim config
- ghostty: `ghostty/.config/ghostty/config`

## Work vs personal

Three Brewfiles:
- `Brewfile` — core tools everyone needs
- `Brewfile.work` — k8s, terraform, cloud CLIs
- `Brewfile.personal` — personal apps

install.sh prompts which to install. Or run manually: `brew bundle --file=Brewfile.work`

Git identity is handled via conditional includes in `.gitconfig` — repos under `~/work/` use work email, repos under `~/Developer/` use personal email.

## Removing a tool config

```bash
cd ~/dotfiles
stow -D toolname      # remove symlinks
rm -rf toolname/       # delete from repo
git add -A && git commit -m "remove toolname"
```
