# macOS-only aliases
[[ "$(uname)" != "Darwin" ]] && return

alias update='brew update && brew upgrade'
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
