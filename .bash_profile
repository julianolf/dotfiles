# improve bash look
export PS1="\[\033[32m\]\u\[\033[92m\]@\[\033[32m\]\h:\[\033[36m\]\w\[\033[m\] \$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# improve ls
alias ls='ls -Gh'

# update path so sbin will be also available
export PATH=/usr/local/sbin:$PATH

# enable homebrew's completions
if type brew 2&>/dev/null; then
  for completion_file in $(brew --prefix)/etc/bash_completion.d/*; do
    source "$completion_file"
  done
fi

# python setup
eval "$(pipenv --completion)"
export WORKON_HOME=~/.venvs
export PIPENV_DEFAULT_PYTHON_VERSION=3
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# ruby setup
eval "$(rbenv init -)"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

