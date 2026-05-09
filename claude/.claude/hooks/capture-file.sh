#!/bin/bash
# PostToolUse/Write|Edit hook — appends file change to session temp file
INPUT=$(cat)
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // "unknown"')
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.path // ""')
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // "Edit"')
TIMESTAMP=$(date '+%H:%M')
TEMP_FILE="/tmp/claude-hub-${SESSION_ID}.jsonl"
echo "{\"type\":\"file\",\"time\":\"${TIMESTAMP}\",\"tool\":$(echo "$TOOL_NAME" | jq -Rs .),\"path\":$(echo "$FILE_PATH" | jq -Rs .)}" >> "$TEMP_FILE"
