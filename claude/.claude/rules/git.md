# Git — commit freely, push never (unless asked)

- MUST commit after each logical, working step without asking — small and atomic, one concern per commit.
- MUST NOT push, force-push, open PRs or create tags unless asked in the current conversation. One "push" approval is not standing approval.
- MUST stage specific paths, not `git add -A` — never sweep the user's pre-existing or unrelated changes into a commit. Check `git status` before starting.
- MUST use conventional subjects: `type(scope): summary` (feat, fix, refactor, docs, chore, test, perf, build, ci). Body explains WHY when not obvious.
- MUST NOT commit secrets, `.env`, keys or tokens — review `git diff --cached` first.
- MUST NOT use `--no-verify`; fix what the hook reports.
- MUST NOT amend, rebase or reset commits that are already pushed.
- MUST ask before `git reset --hard`, `git clean`, `git checkout -- .`/`git restore .`, `git stash drop`, branch deletion — anything that discards uncommitted work.
- If a checkpoint doesn't build/pass yet, prefix the subject with `wip:`.
