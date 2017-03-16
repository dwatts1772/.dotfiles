# history file
export HISTSIZE=1000
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=1000

# env
export EDITOR="vim"
export PAGER="less"
export GREP_COLOR="0;3{{accent.base8()}}"

# colored man
export LESS_TERMCAP_mb=$(printf "\e[0;3{{accent.base8()}}m")
export LESS_TERMCAP_md=$(printf "\e[0;3{{accent.base8()}}m")
export LESS_TERMCAP_me=$(printf "\e[0m")
export LESS_TERMCAP_se=$(printf "\e[0m")
export LESS_TERMCAP_so=$(printf "\e[1;44;33m")
export LESS_TERMCAP_ue=$(printf "\e[0m")
export LESS_TERMCAP_us=$(printf "\e[1;3{{accent.base8()}}m")

# syntax highlight
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)

mainc="{{accent.base8()}}"
sidec="{{accent.base8() + 8}}"

ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=red"
ZSH_HIGHLIGHT_STYLES[reserved-word]="fg=$mainc"
ZSH_HIGHLIGHT_STYLES[alias]="fg=$mainc"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=$mainc"
ZSH_HIGHLIGHT_STYLES[function]="fg=$mainc"
ZSH_HIGHLIGHT_STYLES[command]="fg=$mainc"
ZSH_HIGHLIGHT_STYLES[precommand]="underline,fg=$mainc"
ZSH_HIGHLIGHT_STYLES[commandseparator]="fg=blue"
ZSH_HIGHLIGHT_STYLES[hashed-command]="fg=$mainc"
ZSH_HIGHLIGHT_STYLES[globbing]="fg=yellow"
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="fg=$sidec"
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="fg=$sidec"
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=yellow"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=yellow"
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="fg=blue"
ZSH_HIGHLIGHT_STYLES[redirection]="fg=$sidec"
ZSH_HIGHLIGHT_STYLES[arg0]="fg=$mainc"

export ZSH_HIGHLIGHT_STYLES
export ZSH_HIGHLIGHT_HIGHLIGHTERS

# python virtual env
export VIRTUAL_ENV_DISABLE_PROMPT=true

# node
export NODE_PATH="$HOME/.local/lib/node_modules:$NODE_PATH"

# osx
if [ "$(uname)" = "Darwin" ]; then
  export COREUTILS_HOME="/usr/local/opt/coreutils"
  export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_66.jdk/Contents/Home"
  export ADB_HOME="/usr/local/opt/android-platform-tools"
  export PYTHONUSERBASE="${HOME}/.local"
fi
