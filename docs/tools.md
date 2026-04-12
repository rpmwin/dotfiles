# Tools Reference

Every tool installed by the Brewfile and why it's here.

---

## Shell & Prompt

| Tool | What It Does | How You Use It |
|------|-------------|----------------|
| **zsh** | Your shell. Better than bash for interactive use — better tab completion, plugins, scripting. | It's your default shell. |
| **oh-my-posh** | Prompt theme engine. Shows git branch, exit codes, execution time in your prompt. | Loads automatically via `plugins.zsh`. Theme: Catppuccin Mocha. |
| **fzf** | Fuzzy finder. Search anything by typing partial matches. | `Ctrl+R` = search history. `Ctrl+T` = find files. `Alt+C` = cd into directories. |
| **zoxide** | Smart `cd`. Remembers directories you visit. | Type `z projname` instead of `cd ~/Developer/some/long/path/projname`. It learns. |
| **direnv** | Auto-loads `.envrc` files when you enter a directory. | Put `export AWS_PROFILE=dev` in a project's `.envrc`. It activates when you `cd` in, deactivates when you leave. |
| **atuin** | Shell history sync + search. Better than default history. | `Ctrl+R` opens atuin search (replaces default). History syncs across machines. |
| **zsh-autosuggestions** | Ghost text suggestions as you type, based on history. | Start typing a command → see grey suggestion → press `→` to accept. |
| **zsh-syntax-highlighting** | Colors your commands as you type. Red = invalid, green = valid. | Just type commands. Wrong command names turn red before you hit enter. |

---

## Modern CLI Replacements

These replace old Unix tools with faster, prettier, more useful versions.

| Old Tool | Replacement | Why It's Better |
|----------|-------------|----------------|
| `cat` | **bat** | Syntax highlighting, line numbers, git integration. Aliased: `cat` runs `bat`. |
| `ls` | **eza** | Icons, colors, git status, tree view. Aliased: `ls` runs `eza`. |
| `find` | **fd** | Simpler syntax, respects `.gitignore`, way faster. Use: `fd pattern`. |
| `grep` | **ripgrep (rg)** | Faster, respects `.gitignore`, better defaults. Use: `rg pattern`. |
| `diff` | **delta** | Side-by-side diffs with syntax highlighting. Auto-used by `git diff`. |
| `top` | **btop** | Beautiful system monitor with mouse support. Aliased: `top` runs `btop`. |
| `du` | **dust** | Visual disk usage with bar charts. |
| `df` | **duf** | Prettier disk free output. |

---

## Git Tools

| Tool | What It Does | How You Use It |
|------|-------------|----------------|
| **git** | Version control. You know this one. | `g s` = status, `g save "msg"` = add+commit+push. See aliases in `aliases.zsh`. |
| **gh** | GitHub CLI. PRs, issues, repos from terminal. | `gh pr create`, `gh issue list`, `gh repo clone`. |
| **glab** | GitLab CLI. Same as `gh` but for GitLab. | `glab mr create`, `glab issue list`. |
| **lazygit** | Terminal UI for git. Visual staging, branching, rebasing. | Type `lz` (aliased). Navigate with keyboard. Way faster than typing git commands. |
| **gitleaks** | Scans for secrets in git history. Catches API keys, passwords before they're pushed. | Runs automatically via pre-commit hook. Also: `gitleaks detect`. |
| **delta** | Pretty git diffs. Side-by-side, syntax highlighted. | Configured in `.gitconfig`. Every `git diff` and `git log -p` uses it automatically. |

---

## Dev Tools

| Tool | What It Does | How You Use It |
|------|-------------|----------------|
| **neovim** | Text editor. Configured with kickstart.nvim + custom plugins. | `nv` or `vi` (aliased). |
| **tmux** | Terminal multiplexer. Multiple panes/windows in one terminal. | `t` = tmux, `ta <name>` = attach session, `tn <name>` = new session. |
| **mise** | Language version manager. One tool replaces nvm, pyenv, goenv. | `mise use node@20` in a project. Auto-switches versions per directory. |
| **yazi** | Terminal file manager. Navigate, preview, open files. | Type `y` (aliased). Navigate with vim keys. |
| **uv** | Fast Python package manager. Replaces pip for most things. | `uv pip install`, `uv venv`, `uv run`. |
| **topgrade** | Updates everything at once: brew, npm, pip, etc. | Run `topgrade`. It finds and updates all package managers. |

---

## DevOps Tools

| Tool | What It Does |
|------|-------------|
| **kubectl** | Kubernetes CLI. Aliased: `k get pods`, `kgp`, `kgs`, etc. |
| **k9s** | Terminal UI for Kubernetes. Like lazygit but for k8s. |
| **helm** | Kubernetes package manager. `h`, `hi`, `hup` aliased. |
| **terraform** | Infrastructure as code. `tf`, `tfi`, `tfp`, `tfa` aliased. |
| **argocd** | GitOps continuous delivery for Kubernetes. |
| **kind** | Run local Kubernetes clusters in Docker. For testing. |
| **kubeseal** | Encrypt Kubernetes secrets for git storage. |
| **sops** | Encrypt/decrypt files with AWS KMS, GCP KMS, etc. |
| **nmap** | Network scanner. Port scanning, service detection. |
| **mtr** | Better traceroute. Combines ping + traceroute. |

---

## Aliases Cheat Sheet

All aliases are in `zsh/.zsh/aliases.zsh`. Here are the most useful ones:

```
# Navigation
..          cd ..
...         cd ../..
c           clear
mkd         mkdir -p

# Files
cat         bat (with syntax highlighting)
ls          eza (with icons)
ll          eza -la (detailed)
tree        eza --tree

# Git (most used)
gs          git status -sb
ga          git add
gaa         git add .
gc "msg"    git commit -m "msg"
gp          git push
gpl         git pull
gd          git diff
gl          git log (graph)
lz          lazygit

# g() function (even shorter)
g s         git status
g a         git add .
g c "msg"   git commit -m "msg"
g p         git push
g save "m"  git add . && commit && push

# Docker
d           docker
dc          docker compose
dps         docker ps
dex         docker exec -it

# Kubernetes
k           kubectl
kgp         kubectl get pods
kgs         kubectl get svc
kaf         kubectl apply -f

# Terraform
tf          terraform
tfi         terraform init
tfp         terraform plan
tfa         terraform apply
```
