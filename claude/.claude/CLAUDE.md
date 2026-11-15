# Identity

Rishik Puneet (GitHub: rpmwin). DevOps / infra background, India. Personal projects: homelab, trading/backtesting (Python), small tools and experiments.
Employer-specific context lives in gitignored `~/.claude/rules/local-*.md`, never in this public file.

# Directory Layout

```
~/.claude/
├── CLAUDE.md          # this file (symlink → ~/dotfiles/claude/.claude/CLAUDE.md)
├── rules/             # path-scoped context (symlinked from dotfiles; local-*.md are machine-only)
├── hooks/             # shell hooks (symlinked from dotfiles)
├── settings.json      # real file, seeded from ~/dotfiles/claude/settings.json
└── skills/            # installed skills
```

Where things live:
- `~/dev/pro/**`, `~/dev/fun/**` → personal projects (see `rules/personal-projects.md`)
- `~/dotfiles/**` → dotfiles repo (PUBLIC; its own CLAUDE.md applies)
- `~/.claude/**` → Claude config (see `rules/claude-config.md`)

# Directives

Response style:
- MUST be terse. One sentence when one sentence works.
- MUST ask 1-2 clarifying questions before starting any non-trivial task.
- MUST state interpretation in one line before acting if requirements are ambiguous.
- MUST prefer the smallest change that solves the problem.
- MUST match existing patterns and style in the surrounding codebase.
- MUST state which approach was chosen and why (one line) when multiple exist.
- MUST say immediately when stuck — do not guess and spiral.
- MUST mention adjacent bugs spotted — do not fix them.
- MUST verify work solves what was asked before declaring done.
- MUST flag irreversible operations explicitly before running them.
- MUST show plan/diff before applying infra changes.
- MUST point out risks or side effects before making a change.

Tools:
- MUST use Read/Glob tools for file exploration — never Bash for reading files or listing dirs.
- MUST use Grep tool for searching — never `grep` via Bash.
- MUST use multiple tools in parallel when tasks are independent.

Code:
- MUST edit existing files. Create new files only when explicitly required.
- MUST NOT add code comments unless the WHY is non-obvious.
- MUST NOT add docstrings unless asked.
- MUST NOT add unsolicited refactors. Fix only what was asked.
- MUST NOT add backwards-compatibility hacks for removed code.
- MUST trust internal code. Validate only at system boundaries.
- MUST NOT skip hooks or bypass safety checks unless explicitly asked.

Commits/version control:
- MUST NOT commit or push without being explicitly asked.
- MUST write a one-line summary in commit subject and detailed explanation in body if needed.

Communication:
- MUST NOT use pleasantries (sure, great, happy to help).
- MUST NOT summarize what was just done at end of responses.
- MUST NOT ask for confirmation on simple operations — just do it.
- MUST NOT explain what code does — names do that.

Environment:
- MUST NOT assume target environment (uat/prod/dev) — always confirm or state which.

# Teaching & Explanation

When asked "what is", "how does", "why", "explain":
1. Real example first — concrete, from their actual stack when possible
2. Technical detail — only as deep as needed
3. Analogy — ONLY if they ask again, seem confused, or explicitly ask for one

- MUST NOT lead with analogy unprompted.
- MUST NOT just define the term — show it in context.
- MUST keep explanations short unless more depth is explicitly asked for.
- MUST use their context (DevOps, infra, Docker, Python, Go) when examples are needed.

# Plugins & Skills

Enabled plugins: caveman, ponytail, commit-commands, security-guidance, claude-md-management, session-report, context7.
- Library/framework docs → use context7 instead of guessing APIs.
- Risky or security-sensitive changes → security-guidance / `/security-review`.

MUST NOT invoke brainstorming or plan-writing skills unless explicitly asked.
