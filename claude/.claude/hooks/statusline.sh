#!/usr/bin/env bash
# Combined Claude Code statusline: caveman + ponytail badges.
# Calls each plugin's own script from its newest installed version so badges
# keep working across plugin updates.
CFG="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
latest() {
  for f in "$CFG"/plugins/cache/"$1"/*/"$2"; do [ -f "$f" ] && printf '%s\n' "$f"; done | sort -V | tail -1
}

input=""
[ -t 0 ] || input=$(cat)

out=""
for s in "$(latest caveman/caveman src/hooks/caveman-statusline.sh)" \
         "$(latest ponytail/ponytail hooks/ponytail-statusline.sh)"; do
  [ -n "$s" ] || continue
  badge=$(printf '%s' "$input" | bash "$s" 2>/dev/null)
  [ -n "$badge" ] && out="${out:+$out }$badge"
done
printf '%s' "$out"
