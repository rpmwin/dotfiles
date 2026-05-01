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

# Temp directory for quick experiments — tt [name]
# tt → /tmp/tt, tt foo → /tmp/tt-foo
tt() {
  local name="${1:-}"
  local dir="/tmp/tt${name:+-$name}"
  rm -rf "$dir"
  mkdir -p "$dir"
  cd "$dir"
  git init -q
  cat > CLAUDE.md << 'EOF'
# Throwaway Session

No project context. No rules. Blank slate.
Exploratory only — no assumptions about stack or conventions.
EOF
  git add -A && git commit -q -m "init throwaway session"
  echo "→ $dir"
}

# List active tt sessions
ttls() {
  ls -d /tmp/tt* 2>/dev/null || echo "no tt sessions"
}

# Clean all tt sessions
ttc() {
  rm -rf /tmp/tt* && echo "cleaned"
}

# Git shorthand — g s, g a, g c "msg", g save "msg"
g() {
  case "$1" in
    s)    git status ;;
    a)    git add . ;;
    c)    git commit -m "$2" ;;
    p)    git push ;;
    l)    git log --oneline --graph --decorate ;;
    up)   git pull ;;
    b)    git branch ;;
    save) git add . && git commit -m "$2" && git push ;;
    *)    git "$@" ;;
  esac
}

# Dotfiles manager
dots() {
  case "$1" in
    update) cd "$DOTFILES" && git pull && brew bundle --file="$DOTFILES/Brewfile" && "$DOTFILES/stow.sh" ;;
    edit)   $EDITOR "$DOTFILES" ;;
    cd)     cd "$DOTFILES" ;;
    check)  "$DOTFILES/scripts/symlink-check.sh" ;;
    add)    cd "$DOTFILES" && git add -A && git commit -m "${2:-update dotfiles}" && git push ;;
    status) cd "$DOTFILES" && git status ;;
    *)      echo "Usage: dots {update|edit|cd|check|add|status}" ;;
  esac
}
