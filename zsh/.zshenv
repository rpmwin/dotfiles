# Dotfiles root
export DOTFILES="$HOME/dotfiles"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"

# Editor
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less

# Projects root (override in local.zsh per machine)
export PROJECTS="$HOME/Developer"

# Homebrew — cache prefix once
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
export BREW_PREFIX="$(brew --prefix 2>/dev/null)"

# PATH
export PATH="$HOME/.local/bin:$PATH"
