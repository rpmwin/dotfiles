# Oh-My-Posh prompt
command -v oh-my-posh &>/dev/null && eval "$(oh-my-posh init zsh --config ~/.poshthemes/catppuccin_mocha.omp.json)"

# fzf
if command -v fzf &>/dev/null; then
  eval "$(fzf --zsh)" 2>/dev/null || source <(fzf --zsh) 2>/dev/null
  export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
fi

# Zoxide (smart cd)
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"

# Direnv
command -v direnv &>/dev/null && eval "$(direnv hook zsh)"

# Atuin (shell history)
command -v atuin &>/dev/null && eval "$(atuin init zsh)"

# Mise (language version manager)
command -v mise &>/dev/null && eval "$(mise activate zsh)"

# Autosuggestions + syntax highlighting (via Homebrew)
if [[ -n "$BREW_PREFIX" ]]; then
  [[ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && \
    source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  [[ -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && \
    source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
