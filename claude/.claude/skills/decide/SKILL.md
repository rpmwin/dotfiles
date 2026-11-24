---
name: decide
description: Record a settled technical or product decision as an ADR. Use when the user picks between options or says "let's go with".
---

# Decision record (ADR)

- File: `docs/decisions/NNNN-<slug>.md` with the next free 4-digit number (no repo: `~/dev/notebook/decisions/`).
- MUST NOT change the decision of an accepted ADR. Write a new one with `Supersedes: NNNN` and set the old status to `superseded by MMMM`.
- MUST keep it short: why, what was rejected, what it costs.
- Commit: `docs(adr): NNNN <slug>`.

```markdown
# NNNN. <decision>

Date: YYYY-MM-DD · Status: accepted

## Context
## Options
| Option | Pros | Cons |
|---|---|---|
## Decision
## Consequences
```
