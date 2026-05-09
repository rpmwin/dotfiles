#!/bin/bash
# Stop hook — flushes session temp file into formatted inbox markdown
INPUT=$(cat)
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // "unknown"')
TEMP_FILE="/tmp/claude-hub-${SESSION_ID}.jsonl"

# Nothing captured this session — skip
[ ! -f "$TEMP_FILE" ] && exit 0

DOCS_PATH="${KNOWLEDGE_HUB_PATH:-/Users/iamrpm/docs/claude}"
INBOX_DIR="$DOCS_PATH/inbox"
mkdir -p "$INBOX_DIR"

DATE=$(date '+%Y-%m-%d')
TIME=$(date '+%H%M')
PROJECT=$(basename "$PWD")
SHORT_ID="${SESSION_ID:0:6}"
INBOX_FILE="$INBOX_DIR/${DATE}-${TIME}-${PROJECT}-${SHORT_ID}.md"

START_TIME=$(jq -r '.time' "$TEMP_FILE" 2>/dev/null | head -1)
END_TIME=$(jq -r '.time' "$TEMP_FILE" 2>/dev/null | tail -1)

# First user prompt = what we were doing
FIRST_PROMPT=$(jq -r 'select(.type=="prompt") | .content' "$TEMP_FILE" 2>/dev/null | head -1)

# All prompts
PROMPTS=$(jq -r 'select(.type=="prompt") | "- " + .content' "$TEMP_FILE" 2>/dev/null)

# Commands table
COMMANDS_TABLE=$(jq -r 'select(.type=="command") | "| " + .time + " | `" + .content + "` |"' "$TEMP_FILE" 2>/dev/null)

# Files changed
FILES_TABLE=$(jq -r 'select(.type=="file") | "| " + .path + " | " + .tool + " |"' "$TEMP_FILE" 2>/dev/null | sort -u)

# Errors
ERRORS=$(jq -r 'select(.type=="error") | "**[" + .time + "]** `" + .command + "`\n```\n" + .output + "\n```"' "$TEMP_FILE" 2>/dev/null)

# Build the file — skip sections with no content
{
cat << HEADER
---
id: ${DATE}-${TIME}-${PROJECT}-${SHORT_ID}
project: ${PROJECT}
dir: ${PWD}
start: ${DATE}T${START_TIME:-??:??}
end: ${DATE}T${END_TIME:-??:??}
status: unprocessed
---

## What We Were Doing
${FIRST_PROMPT:-_session started_}

HEADER

if [ -n "$PROMPTS" ]; then
cat << SECTION
## User Prompts
${PROMPTS}

SECTION
fi

if [ -n "$COMMANDS_TABLE" ]; then
cat << SECTION
## Commands Run
| Time | Command |
|------|---------|
${COMMANDS_TABLE}

SECTION
fi

if [ -n "$FILES_TABLE" ]; then
cat << SECTION
## Files Changed
| File | Action |
|------|--------|
${FILES_TABLE}

SECTION
fi

if [ -n "$ERRORS" ]; then
cat << SECTION
## Errors Encountered
${ERRORS}

SECTION
fi

} > "$INBOX_FILE"

rm -f "$TEMP_FILE"
