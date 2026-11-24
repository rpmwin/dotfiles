# Git — commit freely, push never (unless asked)

- MUST commit after each logical, working step without asking — small and atomic, one concern per commit.
- MUST NOT push, force-push, open PRs or create tags unless asked in the current conversation. One "push" approval is not standing approval.
  - Exception: repos whose origin is `github.com/rpmwin/*` — pushing a feature branch and opening a PR at the end of a task is pre-approved. Never push to the default branch, force-push or tag there either.
- MUST stage specific paths, not `git add -A` — never sweep the user's pre-existing or unrelated changes into a commit. Check `git status` before starting.
- MUST use conventional subjects: `type(scope): summary` (feat, fix, refactor, docs, chore, test, perf, build, ci). Imperative, lowercase, no period, under 60 characters.
- Commit body, when the why is not obvious: 1-3 short lines, wrapped at 72, saying what changed and why. No list of every file.
- MUST NOT commit secrets, `.env`, keys or tokens — review `git diff --cached` first.
- MUST NOT use `--no-verify`; fix what the hook reports.
- MUST NOT amend, rebase or reset commits that are already pushed.
- MUST ask before `git reset --hard`, `git clean`, `git checkout -- .`/`git restore .`, `git stash drop`, branch deletion — anything that discards uncommitted work.
- If a checkpoint doesn't build/pass yet, prefix the subject with `wip:`.

## Pull requests

- One concern per PR, small enough to review in 10 minutes.
- Title: the conventional subject of the change.
- MUST use this body; drop a section only when it would be empty:

```markdown
## What
- <one change per line>

## Why
<1-2 sentences: the problem or goal>

## How to test
- <command or step> → <expected result>

## Notes
- <risks, follow-ups, what was not verified>
```
