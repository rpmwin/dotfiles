# =========================================================
# macOS WORKSTATION — COMPLETE .zshrc
# Oh-My-Posh + Catppuccin Mocha + Full DevOps Stack
# =========================================================


# =========================================================
# PROMPT
# =========================================================

eval "$(oh-my-posh init zsh --config ~/.poshthemes/catppuccin_mocha.omp.json)"


# =========================================================
# ENVIRONMENT
# =========================================================

export EDITOR=nvim
export VISUAL=nvim
export PAGER=less
export PATH="/Users/iamrpm/.antigravity/antigravity/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"


# =========================================================
# HISTORY
# =========================================================

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
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS

# Substring search (type partial command + ↑/↓)
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search


# =========================================================
# KEYBINDINGS
# =========================================================

bindkey '^R' history-incremental-search-backward
bindkey '^F' fzf-file-widget 2>/dev/null
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^L' clear-screen

# Word traversal (Ghostty: Alt+← / Alt+→)
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word


# =========================================================
# COMPLETION
# =========================================================

autoload -Uz compinit && compinit
zstyle ':completion:*' menu select


# =========================================================
# FZF
# =========================================================

if command -v fzf >/dev/null; then
  eval "$(fzf --zsh)" 2>/dev/null || source <(fzf --zsh) 2>/dev/null
fi

# =========================================================
# ZOXIDE (smart cd)
# =========================================================

if command -v zoxide >/dev/null; then
  eval "$(zoxide init zsh)"
fi


# =========================================================
# GOOGLE CLOUD SDK
# =========================================================

# Managed via homebrew cask (gcloud-cli) — no manual sourcing needed


# =========================================================
# FUNCTIONS
# =========================================================

# Make directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Kill process on a port
killport() {
  lsof -ti:$1 | xargs kill -9
}

# Extract almost any archive
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz)  tar xzf "$1" ;;
      *.bz2)     bunzip2 "$1" ;;
      *.gz)      gunzip "$1" ;;
      *.tar)     tar xf "$1" ;;
      *.zip)     unzip "$1" ;;
      *.7z)      7z x "$1" ;;
      *) echo "Cannot extract '$1'" ;;
    esac
  else
    echo "'$1' is not valid"
  fi
}


tt (){
  name=$(date +%Y%m%d_%H%M%S)
  mkdir -p /tmp/$name/tt
  cd /tmp/$name/tt

}



# =========================================================
# GENERAL
# =========================================================


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


# =========================================================
# FILE & NAVIGATION
# =========================================================

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


# =========================================================
# SYSTEM (macOS)
# =========================================================

alias update='brew update && brew upgrade'
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'

alias psa='ps aux'
alias top='btop'
alias killp='pkill -f'


# =========================================================
# NETWORKING
# =========================================================

alias ports='lsof -i -P -n | grep LISTEN'
alias myip='curl -s ifconfig.me'
alias ippublic='curl -s ifconfig.me'
alias pingg='ping 8.8.8.8'


# =========================================================
# GIT
# =========================================================

#alias g='git'
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


# =========================================================
# DOCKER
# =========================================================

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


# =========================================================
# KUBERNETES
# =========================================================

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

# HELM

alias h="helm"
alias hi="helm install"
alias hup="helm upgrade"



# =========================================================
# TERRAFORM
# =========================================================

alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'


# =========================================================
# CLOUD
# =========================================================

alias gcp='gcloud'
alias awslogin='aws sso login --sso-session work && yawsso -p hf-infra hf-nonprod hf-new-nonprod hf-old-non-prod hf-new-prod'


# =========================================================
# TMUX
# =========================================================

alias t='tmux'
alias ta='tmux attach -t'
alias tls='tmux ls'
alias tn='tmux new -s'


# =========================================================
# PLUGINS (loaded last)
# =========================================================

if [ -f ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [ -f ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi


# =========================================================
# fun-functions 
# =========================================================


g() {
  case "$1" in
    # 'g s' -> git status
    s)  git status ;;
    # 'g a' -> git add (all)
    a)  git add . ;;
    # 'g c "msg"' -> git commit -m
    c)  git commit -m "$2" ;;
    # 'g p' -> git push
    p)  git push ;;
    # 'g l' -> pretty log
    l)  git log --oneline --graph --decorate ;;
    # 'g up' -> pull with rebase
    up) git pull ;;
    # 'g save "msg"' -> add, commit, and push in one go
    save)
        git add .
        git commit -m "$2"
        git push
        ;;
    b) git branch ;;
    # If no match, just pass the command through to git
    *)  git "$@" ;;
  esac
}



# =========================================================
## Claude-Code  
# =========================================================

alias cc="claude"



eval "$(direnv hook zsh)"
