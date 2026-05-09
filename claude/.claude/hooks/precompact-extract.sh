#!/bin/bash
# PreCompact hook — injects knowledge extraction instructions into compaction context
DOCS_PATH="${KNOWLEDGE_HUB_PATH:-/Users/iamrpm/docs/claude}"

# Find the most recent unprocessed inbox file
LATEST_INBOX=$(ls -t "$DOCS_PATH/inbox/"*.md 2>/dev/null | head -1)

if [ -z "$LATEST_INBOX" ]; then
  INBOX_REF="no inbox file found yet"
else
  INBOX_REF="$LATEST_INBOX"
fi

CONTEXT="KNOWLEDGE EXTRACTION — Before compacting, please do the following:
1. Review this session for non-obvious, reusable technical learnings (skip routine commands, obvious facts, and small talk).
2. For each meaningful learning: determine domain (technical/devops/soft-skills/meta), find or create the topic file at $DOCS_PATH/knowledge/<domain>/<topic>.md, append the learning with today's date and a source link.
3. Update $DOCS_PATH/knowledge/_index/$(date '+%Y-%m').md — add links to any new/updated knowledge sections.
4. If inbox file exists at $INBOX_REF — update its status to 'processed', add 'processed-on' and 'knowledge-updated' fields, then move it to $DOCS_PATH/sessions/\$(basename \$PWD)/\$(basename \$LATEST_INBOX).
5. Only if this session had meaningful learnings worth keeping — otherwise skip extraction and compact normally.
Use Write and Edit tools to make these changes. Do this BEFORE the compaction summary."

printf '%s' "$CONTEXT" | jq -Rs '{hookSpecificOutput: {hookEventName: "PreCompact", additionalContext: .}}'
