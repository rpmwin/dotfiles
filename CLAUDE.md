# CLAUDE.md

Personal dotfiles for rpmwin, managed with GNU Stow. Source of truth for every machine — any config change made on a machine should land here and be pushed (`dots add "msg"`).

**This repo is PUBLIC** (github.com/rpmwin/dotfiles). Never commit secrets, private keys, tokens, work/employer details, internal hostnames or IPs. Those go in the gitignored local files listed below.

## Bootstrap a new machine

```bash
git clone https://github.com/rpmwin/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./install.sh   # brew → Brewfile(s) → backup → stow → macOS defaults
```

Re-stow (safe to re-run): `./stow.sh`. First time on a machine with existing files: `./stow.sh --adopt`, then `git diff` to review what got pulled in.

## Day-to-day

```bash
dots update    # git pull + brew bundle + re-stow
dots check     # verify symlinks point into ~/dotfiles
dots add "msg" # git add -A + commit + push
dots edit      # open repo in $EDITOR
dots status    # git status of the repo
```

Installed a new tool? Add it to the right Brewfile in the same change.

## Layout

Every top-level dir except `scripts/ hooks/ docs/ .github/` is a stow package, symlinked into `$HOME`:

| Package | Lands at |
|---|---|
| `zsh/` | `~/.zshrc`, `~/.zshenv`, `~/.zlogin`, `~/.zsh/*.zsh` |
| `git/` | `~/.gitconfig`, `~/.gitconfig-personal`, `~/.gitignore_global` |
| `ghostty/` `bat/` `btop/` `lazygit/` `yazi/` `atuin/` `mise/` `nvim/` | `~/.config/<tool>/` |
| `tmux/` | `~/.tmux.conf` (plugins via TPM in `~/.tmux/plugins`) |
| `posh/` | `~/.poshthemes/` (oh-my-posh Catppuccin Mocha) |
| `ssh/` | `~/.ssh/config` (no keys, ever) |
| `claude/` | `~/.claude/CLAUDE.md`, `~/.claude/rules/`, `~/.claude/skills/<name>/`, `~/.claude/hooks/` |

`claude/settings.json` sits *outside* `.claude/` on purpose: Claude Code rewrites `~/.claude/settings.json` itself, so it is a template that `install.sh` copies in only when missing. Sync changes back by hand.

## Brewfiles

- `Brewfile` — everything every machine gets (CLI, shell, dev, containers, fonts, Ghostty)
- `Brewfile.personal` — GUI apps + VS Code extensions; optional apps are commented out
- `Brewfile.work` — work-only DevOps tools (terraform, helm, k9s, gcloud…)

Brewfile syntax is `brew "x"` / `cask "x"` / `tap "x"` / `vscode "x"` — never `brew install "x"`.

## zsh load order

`.zshrc` is a thin sourcer:

1. `.zshenv` — `$DOTFILES`, `$PROJECTS` (`~/dev`), brew shellenv, `$BREW_PREFIX`, `$PATH`, `$EDITOR`
2. `.zsh/exports.zsh` — history, shell options
3. `.zsh/completions.zsh` — completion, keybindings
4. `.zsh/aliases.zsh` — all aliases
5. `.zsh/functions.zsh` — `mkcd killport extract tt ttls ttc g dots`
6. `.zsh/plugins.zsh` — oh-my-posh, fzf, zoxide, direnv, atuin, mise, autosuggestions, syntax-highlighting (last)
7. `.zsh/macos.zsh` / `.zsh/linux.zsh` — OS-gated
8. `~/.zsh/local.zsh` — machine-local overrides + secrets (gitignored)

New alias → `aliases.zsh`. New function → `functions.zsh`. OS-specific → platform file. Check an alias/function doesn't already exist before adding one.

## Machine-local (gitignored) files

| File | Use |
|---|---|
| `~/.zsh/local.zsh` | secrets, API keys, work aliases, machine-only PATH |
| `~/.gitconfig.local` | work identity + `includeIf` for work dirs |
| `~/.ssh/config.local` | private hosts (servers, work GitHub accounts) |
| `~/.claude/rules/local-*.md` | employer/project-specific Claude rules |

## Git identity

`~/.gitconfig` defaults to personal (rpmwin). Repos under `~/dev/` include `~/.gitconfig-personal`. Work identity is added per machine in `~/.gitconfig.local`.

## Projects

Projects live in `~/dev` (`~/dev/pro`, `~/dev/fun`). `$PROJECTS` drives the tmux sessionizer (`prefix f`).

## Safety

- Pre-commit hook (`git config core.hooksPath hooks/`, set by `install.sh`) runs `shellcheck` on staged shell scripts and `gitleaks protect --staged`.
- CI (GitHub Actions, macOS + Ubuntu): stow `--simulate` for every package + shellcheck.

## Editing rules for Claude

- Test shell changes with `zsh -i -c exit` (and `source ~/.zshrc`) before calling it done.
- Don't break stow symlinks — edit files in the repo (or via their `~` symlink), never replace the symlink with a copy.
- Prefer POSIX-ish shell unless a zsh feature is intentional.
- Commit each logical change (specific paths, conventional subject); push only when asked.
