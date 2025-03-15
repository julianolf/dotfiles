export LC_ALL=en_US.UTF-8
export LOCAL_BIN="$HOME/.local/bin"
export PYENV_ROOT="$HOME/.pyenv"
export GOPATH="$HOME/go"
export CARGOPATH="$HOME/.cargo"
export PATH="$LOCAL_BIN:$PYENV_ROOT/bin:$GOPATH/bin:$CARGOPATH/bin:$PATH"
export ANTHROPIC_API_KEY="$(cat $HOME/.anthropic)"
export OPENAI_API_KEY="$(cat $HOME/.openai)"
