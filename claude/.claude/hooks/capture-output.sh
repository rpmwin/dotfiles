#!/bin/bash
# PostToolUse/Bash hook — captures error output from commands
INPUT=$(cat)
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // "unknown"')
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // ""')

# Skip trivial commands
case "$COMMAND" in
  ls*|cd*|pwd|cat*|echo*|head*|tail*|"") exit 0 ;;
esac

# tool_response contains the bash output
OUTPUT=$(echo "$INPUT" | jq -r '.tool_response // ""' 2>/dev/null)
[ -z "$OUTPUT" ] && exit 0

# Capture if output contains error/failure patterns
if echo "$OUTPUT" | grep -qiE "(error|failed|not found|permission denied|panic:|fatal|exception|no such|cannot|undefined|traceback|exit code [^0])"; then
  TIMESTAMP=$(date '+%H:%M')
  TEMP_FILE="/tmp/claude-hub-${SESSION_ID}.jsonl"
  TRIMMED=$(echo "$OUTPUT" | head -15 | cut -c1-500)
  echo "{\"type\":\"error\",\"time\":\"${TIMESTAMP}\",\"command\":$(echo "$COMMAND" | jq -Rs .),\"output\":$(echo "$TRIMMED" | jq -Rs .)}" >> "$TEMP_FILE"
fi
