# Token Economy

Always loaded. Every token in context is re-sent on every turn, so waste compounds.

## Reading

- MUST read only what the task needs: Grep/Glob first, then Read with `offset`/`limit` on large files.
- MUST NOT re-read a file already in context or just edited.
- MUST cap command output (`| head`, `--quiet`, `-q`, `--oneline`); never dump full logs, lockfiles or minified/generated files.
- SHOULD prefer structured text (JSON, `--format`, `jq`) over prose or images.

## Acting

- MUST batch independent tool calls in one turn; prefer batch tools (e.g. `browser_batch`) over one call per step.
- MUST load deferred tools in one ToolSearch call with every tool expected.
- MUST stop after 2 failed attempts at the same approach and ask, not loop.
- SHOULD use a subagent only for broad, noisy searches whose dumps would flood main context; never for a known file or symbol.

## Writing

- MUST keep replies to the answer: no recap of tool output, no restating the question.
- MUST show only changed lines plus 1-2 lines of context for edits shown in chat.

## Session hygiene (tell the user when it applies)

- Suggest `/clear` when switching to an unrelated task.
- Suggest `/compact` with what to keep when context is large mid-task.
