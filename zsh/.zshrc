# ~/.zshrc — master sourcer
# All config lives in ~/.zsh/*.zsh topic files

# Topic files (order matters)
source ~/.zsh/exports.zsh
source ~/.zsh/completions.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/plugins.zsh

# OS-specific
[[ "$(uname)" == "Darwin" ]] && source ~/.zsh/macos.zsh
[[ "$(uname)" == "Linux" ]]  && source ~/.zsh/linux.zsh

# Machine-local overrides + secrets (gitignored)
[[ -f ~/.zsh/local.zsh ]] && source ~/.zsh/local.zsh
