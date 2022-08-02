alias ls="ls -Gh"
alias vi="nvim"
alias vim="nvim"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi
