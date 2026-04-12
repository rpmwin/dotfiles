# TODOS

## P2: Shell Startup Optimization
**What:** Cache `eval "$(tool init zsh)"` output to files, source cached versions instead.
**Why:** 6 eval calls fork subprocesses on every shell open. Combined ~300-500ms tax.
**How:** After Phase 3 ships, measure with `time zsh -i -c exit`. If >500ms, create
`~/.zsh/cache/` directory. Each `dots update` regenerates cache files. `.zshrc` sources
cache if fresh, falls back to eval if stale.
**Effort:** S (human) / S (CC)
**Depends on:** Phase 3 complete (all tools installed and init'd)

## P2: Documentation in docs/
**What:** Create `docs/` directory with short, organized topic files.
**Why:** README covers quickstart but not the full picture. New-to-you-in-6-months needs docs.
**Files:** setup.md, structure.md, tools.md, customization.md, cross-platform.md
**Effort:** S (human) / XS (CC)
**Depends on:** Phase 4 (write after everything works)

## P3: chezmoi Migration Path
**What:** Evaluate chezmoi as replacement for stow if multi-machine templating is needed.
**Why:** Stow is great for one profile. chezmoi handles machine-specific templates, encryption.
**Effort:** M (human) / S (CC)
**Depends on:** Using dotfiles on 3+ machines with divergent configs

## P3: Nix / home-manager
**What:** Declarative, reproducible machine configuration.
**Why:** The endgame for reproducible environments. One config, any machine, identical result.
**Effort:** XL (human) / L (CC)
**Depends on:** Comfort with the current stow setup

## P3: 1Password CLI for Secrets
**What:** Replace local.zsh secrets with `op run` or `op read` from 1Password vault.
**Why:** Secrets never touch disk. Rotatable. Shared across machines via 1Password.
**Effort:** S (human) / S (CC)
**Depends on:** 1Password account + CLI installed
