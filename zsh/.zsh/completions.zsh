# Completion engine
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select

# Substring search (type partial command + ↑/↓)
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Keybindings
bindkey '^R' history-incremental-search-backward
bindkey '^F' fzf-file-widget 2>/dev/null
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^L' clear-screen

# Word traversal (Ghostty: Alt+← / Alt+→)
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word
