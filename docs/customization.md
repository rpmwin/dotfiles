# Customization Guide

How to make this setup your own.

---

## Adding Machine-Specific Config (local.zsh)

The most common customization. Create `~/.zsh/local.zsh` for anything that shouldn't be committed:

```bash
touch ~/.zsh/local.zsh
```

This file is:
- **Gitignored** — never committed, never pushed
- **Sourced last** — can override anything in the other topic files
- **Optional** — if it doesn't exist, nothing breaks

### What goes in local.zsh?

```bash
# Work credentials and SSO
alias awslogin='aws sso login --sso-session work && yawsso -p hf-infra'
export AWS_DEFAULT_REGION="ap-south-1"

# Custom paths
export PROJECTS="$HOME/work/repos"
export PATH="/some/custom/tool/bin:$PATH"

# Proxy (if behind corporate firewall)
export HTTP_PROXY="http://proxy.corp.com:8080"
export HTTPS_PROXY="$HTTP_PROXY"
export NO_PROXY="localhost,127.0.0.1,.corp.com"

# Machine-specific aliases
alias vpn='sudo openconnect vpn.work.com'
```

---

## Adding a New Tool Config

### Step 1: Create the directory structure

The directory inside the stow package must mirror where the config lives in `~`.

```bash
# If config lives at ~/.config/starship/starship.toml:
mkdir -p ~/dotfiles/starship/.config/starship

# If config lives at ~/.tool.conf:
mkdir -p ~/dotfiles/tool
```

### Step 2: Move your config into the package

```bash
# Move (not copy!) so there's no duplicate
mv ~/.config/starship/starship.toml ~/dotfiles/starship/.config/starship/
```

### Step 3: Create the symlink

```bash
cd ~/dotfiles
stow starship
# Or just run ./stow.sh — it auto-detects new directories
```

### Step 4: Verify and commit

```bash
# Check the symlink exists
ls -la ~/.config/starship/starship.toml

# Commit
git add starship/
git commit -m "add starship config"
```

---

## Adding New Aliases

Edit `zsh/.zsh/aliases.zsh`. Group them under a comment header:

```bash
# Ansible
alias ap='ansible-playbook'
alias av='ansible-vault'
```

Then reload: `rz` (aliased to `source ~/.zshrc`).

---

## Adding New Shell Functions

Edit `zsh/.zsh/functions.zsh`. Add your function:

```bash
# SSH into a k8s pod by partial name
ksh() {
  pod=$(kubectl get pods | grep "$1" | head -1 | awk '{print $1}')
  kubectl exec -it "$pod" -- /bin/sh
}
```

---

## Adding New Plugins/Tools

### If installed via Homebrew:

1. Add to `Brewfile`:
   ```ruby
   brew "newtool"
   ```

2. Run `brew bundle`

3. If it needs shell init (like zoxide, direnv, etc.), add to `plugins.zsh`:
   ```bash
   command -v newtool &>/dev/null && eval "$(newtool init zsh)"
   ```

### If it needs a config file:

Follow the "Adding a New Tool Config" steps above.

---

## Changing the Theme

Everything uses **Catppuccin Mocha**. To switch flavors (Latte, Frappe, Macchiato):

1. **oh-my-posh**: Replace `catppuccin_mocha.omp.json` in `posh/.poshthemes/`
2. **bat**: Change `--theme` in `bat/.config/bat/config`
3. **btop**: Change `color_theme` in `btop/.config/btop/btop.conf`
4. **lazygit**: Update colors in `lazygit/.config/lazygit/config.yml`
5. **yazi**: Replace `theme.toml` in `yazi/.config/yazi/`
6. **delta**: Change `syntax-theme` in `git/.gitconfig` under `[delta]`
7. **nvim**: Change colorscheme in nvim config
8. **ghostty**: Change theme in `ghostty/.config/ghostty/config`

---

## Work vs Personal Machine Setup

The Brewfile is split into three:

- `Brewfile` — Core tools everyone needs
- `Brewfile.work` — k8s, terraform, cloud CLIs
- `Brewfile.personal` — Personal apps

During `install.sh`, you're prompted which to install. You can also run them manually:

```bash
brew bundle --file=Brewfile.work
brew bundle --file=Brewfile.personal
```

### Git identity (work vs personal)

Already set up via conditional includes in `.gitconfig`:

```gitconfig
[includeIf "gitdir:~/work/"]
    path = ~/.gitconfig-work

[includeIf "gitdir:~/Developer/"]
    path = ~/.gitconfig-personal
```

Repos under `~/work/` use work email. Repos under `~/Developer/` use personal email.

---

## Removing a Tool Config

```bash
# Unstow (removes symlinks)
cd ~/dotfiles
stow -D toolname

# Delete the directory
rm -rf toolname/

# Commit
git add -A && git commit -m "remove toolname config"
```
