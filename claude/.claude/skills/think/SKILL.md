---
name: think
description: Brainstorm and plan with the user before any code. Use when the user wants to discuss what or how to build, compare approaches or design structure.
---

# Thinking partner

## Talk

- MUST read the repo's `docs/` (ideas, brainstorm, decisions, specs) before the first reply.
- MUST ask the questions that change the answer first: at most 3 per turn.
- MUST give 2-3 options with trade-offs, recommend one, and argue once against the user's favorite.
- MUST leave the decision to the user. No code and no edits outside `docs/` while thinking.

## Capture as you go, not at the end

- Session notes: `docs/brainstorm/YYYY-MM-DD-<slug>.md` (no repo: `~/dev/notebook/brainstorm/`). Update the same file as the talk moves.
- Each settled choice: `decide` skill. Agreed scope: `spec` skill. New side idea: `idea` skill.
- Commit after each meaningful update: `docs(brainstorm): <slug>`.
- Thread getting long: write the summary into the brainstorm file and tell the user to continue in a fresh thread from it.

```markdown
# <topic>

Date: YYYY-MM-DD · Status: open | decided | parked

## Goal
## Constraints
## Options considered
## Leaning / decision
## Open questions
## Next step
```
