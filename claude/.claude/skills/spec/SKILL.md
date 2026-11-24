---
name: spec
description: Turn an agreed idea into a spec with a PR-sized task list. Use before implementing anything bigger than one small change.
---

# Spec

- File: `docs/specs/<slug>.md`. Link the idea, brainstorm and ADRs it comes from.
- MUST split work into tasks of one PR each, ordered so each merges on its own.
- Each task runs as one thread = one worktree = one PR: "implement task N of docs/specs/<slug>.md".
- When a task's PR merges: tick it and add the PR link. Set Status: done when all are ticked.
- Commit: `docs(spec): <slug>`.

```markdown
# <feature>

Status: draft | ready | in progress | done
Sources: <idea / brainstorm / ADR links>

## Goal
## Scope
## Out of scope
## Design
## Acceptance criteria
## Tasks
- [ ] 1. <one PR-sized task>
```
