#!/bin/bash
# UserPromptSubmit hook — appends user prompt to session temp file
INPUT=$(cat)
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // "unknown"')
PROMPT=$(echo "$INPUT" | jq -r '.prompt // ""')
TIMESTAMP=$(date '+%H:%M')
TEMP_FILE="/tmp/claude-hub-${SESSION_ID}.jsonl"
echo "{\"type\":\"prompt\",\"time\":\"${TIMESTAMP}\",\"content\":$(echo "$PROMPT" | jq -Rs .)}" >> "$TEMP_FILE"
