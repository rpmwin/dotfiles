---
glob: /Users/iamrpm/.claude/**
---

# Claude Config Context

Editing Claude Code configuration: settings, hooks, skills, memory.

## Directives

- MUST preserve all existing keys in `settings.json` — never remove entries without explicit instruction.
- MUST NOT add `permissions.deny` entries without asking first.
- MUST check `MEMORY.md` index before writing new memories — avoid duplicates.
- MUST use the `Skill` tool to invoke skills — never read skill files directly with the Read tool.
- MUST clarify scope before adding hooks — session-scoped vs permanent (settings.json) behave differently.
