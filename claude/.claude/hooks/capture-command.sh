#!/bin/bash
# PreToolUse/Bash hook — appends bash command to session temp file
INPUT=$(cat)
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // "unknown"')
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // ""')
# Skip trivial commands — not worth logging
case "$COMMAND" in
  ls*|cd*|pwd|cat*|echo*|"") exit 0 ;;
esac
TIMESTAMP=$(date '+%H:%M')
TEMP_FILE="/tmp/claude-hub-${SESSION_ID}.jsonl"
echo "{\"type\":\"command\",\"time\":\"${TIMESTAMP}\",\"content\":$(echo "$COMMAND" | jq -Rs .)}" >> "$TEMP_FILE"
