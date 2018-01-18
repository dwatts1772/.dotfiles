# history file
export HISTSIZE=1000
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=1000

# env
export EDITOR="vim"
export PAGER="less"

# python virtual env
export VIRTUAL_ENV_DISABLE_PROMPT=true

# node
export NODE_PATH="$HOME/.local/lib/node_modules:$NODE_PATH"

# osx
if [ "$(uname)" = "Darwin" ]; then
    export COREUTILS_HOME="/usr/local/opt/coreutils"
    export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
    export PYTHONUSERBASE="${HOME}/.local"
fi
