# Dotfiles root
export DOTFILES="$HOME/dotfiles"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"

# Editor
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less

# Projects root (override in local.zsh per machine)
export PROJECTS="$HOME/dev"

# Homebrew — cache prefix once
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
elif [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
export BREW_PREFIX="$(brew --prefix 2>/dev/null)"

# PATH
export BUN_INSTALL="$HOME/.bun"
export PATH="$HOME/.local/bin:$BUN_INSTALL/bin:$HOME/.opencode/bin:$HOME/go/bin:$PATH"

# Telemetry opt-outs (apps started from a shell, e.g. Ovis via herdr)
export OVIS_TELEMETRY=0
