# General
alias reload='source ~/.zshrc'
alias rz='source ~/.zshrc'
alias cls='clear'
alias c='clear'
alias mkd='mkdir -p'
alias hist='history 20'
alias hg='history | grep'
alias wh='which'
alias lg='ll | grep'
alias path='echo $PATH | tr ":" "\n"'
alias ez='nvim ~/.zshrc'
alias y='yazi'


# File & Navigation
alias ls='eza --icons --group-directories-first'
alias ll='eza -la --group --icons --group-directories-first'
alias la='eza -la --icons --group-directories-first'
alias lsd='eza -d */'
alias tree='eza --tree --icons'

alias cat='bat --paging=never --style=plain'
alias less='bat'

alias vi='nvim'
alias nv='nvim'

alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias rmf='rm -rf'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias df='df -h'
alias du='du -h'
alias disks='du -h -d 1 | sort -hr'

alias grep='grep --color=auto'
alias rgi='rg -i'

# Networking
alias ports='lsof -i -P -n | grep LISTEN'
alias myip='curl -s ifconfig.me'
alias ippublic='curl -s ifconfig.me'
alias pingg='ping 8.8.8.8'

# Git
alias lz='lazygit'
alias gs='git status -sb'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gp='git push'
alias gpu='git push'
alias gpl='git pull'
alias gf='git fetch'
alias gb='git branch'
alias gco='git checkout'
alias gsw='git switch'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline --graph --decorate --all'
alias gr='git restore'
alias grs='git restore --staged'
alias grh='git reset --hard'
alias gclean='git clean -fd'
alias gst='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'

# Docker
alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias dpa='docker ps -a'
alias di='docker images'
alias dlogs='docker logs -f'
alias dex='docker exec -it'
alias dstart='docker start'
alias dstop='docker stop $(docker ps -q)'
alias drm='docker rm $(docker ps -aq)'
alias dprune='docker system prune -f'

# Kubernetes
alias k='kubectl'
alias kg='kubectl get'
alias kgp='kubectl get pods'
alias kgd='kubectl get deploy'
alias kge='kubectl get events'
alias kgs='kubectl get svc'
alias kgn='kubectl get nodes'
alias kaf='kubectl apply -f'
alias kdf='kubectl delete -f'
alias kc="kubectl config"
alias kl="kubectl logs"
alias kd="kubectl describe"
alias kexec="kubectl exec -it"

# Helm
alias h="helm"
alias hi="helm install"
alias hup="helm upgrade"

# Terraform
alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'

# Cloud
alias gcp='gcloud'

# Tmux
alias t='tmux'
alias ta='tmux attach -t'
alias tls='tmux ls'
alias tn='tmux new -s'

# Claude Code
alias cc="claude"

# System
alias psa='ps aux'
alias top='btop'
alias killp='pkill -f'
