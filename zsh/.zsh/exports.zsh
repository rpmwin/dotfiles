# PATH — re-prepend user dirs: macOS /etc/zprofile (path_helper) runs after .zshenv
# in login shells and pushes /usr/local/bin ahead of them
typeset -U path
path=("$HOME/.local/bin" "$BUN_INSTALL/bin" "$HOME/.opencode/bin" "$HOME/go/bin" $path)

# History
HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt EXTENDED_HISTORY

# Shell behavior
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS
