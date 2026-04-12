# Tools

Every tool in the Brewfile and what it does.

## Shell

- **zsh** — your shell
- **oh-my-posh** — prompt theme (shows git branch, exit codes, etc.)
- **fzf** — fuzzy finder. `Ctrl+R` searches history, `Ctrl+T` finds files, `Alt+C` jumps to directories
- **zoxide** — smart cd. Type `z projname` instead of full paths. It learns from your usage
- **direnv** — auto-loads `.envrc` when you cd into a directory
- **atuin** — better shell history search, syncs across machines
- **zsh-autosuggestions** — grey ghost text as you type, press right arrow to accept
- **zsh-syntax-highlighting** — colors commands as you type (red = invalid, green = valid)

## Modern replacements for old tools

- **bat** replaces `cat` — syntax highlighting, line numbers. Aliased so `cat` runs bat
- **eza** replaces `ls` — icons, colors, git status. Aliased so `ls` runs eza
- **fd** replaces `find` — simpler syntax, faster, respects .gitignore
- **ripgrep (rg)** replaces `grep` — way faster, respects .gitignore
- **delta** replaces `diff` — side-by-side diffs with syntax highlighting. Used automatically by git
- **btop** replaces `top` — beautiful system monitor. Aliased so `top` runs btop

## Git

- **lazygit** — terminal UI for git. Type `lz`. Visual staging, branching, rebasing
- **gh** — GitHub CLI. `gh pr create`, `gh issue list`
- **glab** — GitLab CLI
- **gitleaks** — scans for leaked secrets. Runs automatically via pre-commit hook
- **delta** — pretty git diffs. Configured in .gitconfig, works automatically

## Dev

- **neovim** — text editor. `nv` or `vi`
- **tmux** — terminal multiplexer. `t`, `ta <name>`, `tn <name>`
- **mise** — language version manager (replaces nvm, pyenv, goenv). `mise use node@20`
- **yazi** — terminal file manager. Type `y`
- **uv** — fast Python package manager
- **topgrade** — updates everything at once (brew, npm, pip, etc.)

## DevOps

- **kubectl** — k8s CLI. `k`, `kgp`, `kgs`, `kaf`
- **k9s** — terminal UI for Kubernetes
- **helm** — k8s package manager. `h`, `hi`, `hup`
- **terraform** — infrastructure as code. `tf`, `tfi`, `tfp`, `tfa`
- **argocd** — GitOps for Kubernetes
- **kind** — local k8s clusters in Docker
- **kubeseal** — encrypt k8s secrets for git
- **sops** — encrypt files with KMS
- **nmap** — network scanner
- **mtr** — better traceroute

## Most-used aliases

```
..          cd ..
c           clear
cat         bat
ls          eza (with icons)
ll          detailed listing
tree        eza --tree

gs          git status
ga          git add
gc "msg"    git commit -m
gp          git push
gpl         git pull
gd          git diff
lz          lazygit

g s         git status (even shorter)
g save "m"  add + commit + push in one go

k           kubectl
kgp         kubectl get pods
dc          docker compose
tf          terraform
```

All aliases are in `zsh/.zsh/aliases.zsh`.
