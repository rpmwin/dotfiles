# Linux-only config
[[ "$(uname)" != "Linux" ]] && return

alias update='sudo apt update && sudo apt upgrade -y'
