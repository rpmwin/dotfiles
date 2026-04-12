#!/bin/bash
# Fuzzy-find a project directory and open/attach a tmux session for it
# Bound to Ctrl+F in tmux

PROJECTS="${PROJECTS:-$HOME/Developer}"

# Pick a project
selected=$(fd --type d --max-depth 2 . "$PROJECTS" | fzf --height 40% --reverse)
[[ -z "$selected" ]] && exit 0

# Session name from directory name (replace dots with underscores)
session_name=$(basename "$selected" | tr . _)

# Create session if it doesn't exist
if ! tmux has-session -t="$session_name" 2>/dev/null; then
  tmux new-session -ds "$session_name" -c "$selected"
fi

# Attach or switch
if [[ -z "$TMUX" ]]; then
  tmux attach -t "$session_name"
else
  tmux switch-client -t "$session_name"
fi
