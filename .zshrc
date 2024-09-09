alias ls="ls -Gh"
alias vi="nvim"
alias vim="nvim"

if command -v pyenv 1>/dev/null 2>&1; then
	eval "$(pyenv init --path)"
fi

if command -v rbenv 1>/dev/null 2>&1; then
	eval "$(rbenv init - --no-rehash zsh)"
fi

if test -f "$HOME/Library/google-cloud-sdk/path.zsh.inc"; then
	source "$HOME/Library/google-cloud-sdk/path.zsh.inc"
fi
