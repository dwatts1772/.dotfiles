#              __
#  ____  _____/ /_
# /_  / / ___/ __ \
#  / /_(__  ) / / /
# /___/____/_/ /_/
#

#---[PATH]----------------------------------------------------------------------
if [ "$(uname)" = "Darwin" ]; then
  # brew fix
  PATH="/usr/local/bin:${PATH}"

  # gnu bin
  PATH="${COREUTILS_HOME}/libexec/gnubin:${PATH}"
  MANPATH="${COREUTILS_HOME}/libexec/gnuman:$MANPATH"

  #java
  PATH="${JAVA_HOME}/bin:${PATH}"

  # adb
  PATH="${ADB_HOME}/bin:${PATH}"
fi

export MYBIN_HOME="${HOME}/.local"
export PATH="${MYBIN_HOME}/bin:${HOME}/.cargo/bin:${PATH}"
export MANPATH="${MYBIN_HOME}/share/man:$MANPATH"


#---[zgen loading]--------------------------------------------------------------
zgen_remote="https://github.com/tarjoilija/zgen"
zgen_home="$HOME/.zgen"
[ ! -d "$zgen_home" ] && git clone "$zgen_remote" "$zgen_home"
export ZGEN_DIR="$zgen_home"
source "$zgen_home/zgen.zsh"
unset zgen_remote zgen_home

#---[custom completition path]--------------------------------------------------
fpath=(~/.zsh/completion $fpath)

autoload -U compinit
compinit

#---[plugins]-------------------------------------------------------------------
MINIMAL_OK_COLOR={{accent.base8()}}

minimal_tmux_sessions() {
    local c="$MINIMAL_OK_COLOR"
    local fmt="\e[38;5;244m#{?session_attached,\e[0;3${c}m,} #S\e[0m"
    tmux list-sessions -F "$fmt" 2> /dev/null
}

minimal_magic_output() {
    local sessions="$(minimal_tmux_sessions)"
    if [ "$(echo $sessions | wc -l)" -gt 1 ]; then
        echo -n "[\e[38;5;244mtmux\e[0m -"
        minimal_tmux_sessions | tr -d '\n'
        echo "\e[0m]"
    fi
    ls -C --color="always" -w $((COLUMNS - 4))
    git -c color.status=always status -sb 2> /dev/null
}

if ! zgen saved; then
    zgen load subnixr/minimal
    zgen load zsh-users/zsh-syntax-highlighting
    zgen save
fi

#---[no history duplicates]-----------------------------------------------------
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

#---[case insensitive completition]---------------------------------------------
zstyle ':completion:*' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

#---[vimode]--------------------------------------------------------------------
bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
#bindkey '^h' backward-delete-char
#bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-backward
bindkey -M vicmd 'j' history-beginning-search-forward
bindkey -M vicmd 'k' history-beginning-search-backward
bindkey -M vicmd 'K' run-help

export KEYTIMEOUT=1


#---[aliases]-------------------------------------------------------------------
alias ls="ls --color=auto"
alias l="ls -lah"
alias grep="grep --color=auto"

alias pdb="python3 -m pdb"

# git
alias gst='git status -s'
alias gc='git commit'
alias gcm='git commit -m'
alias ga='git add'

# git flow
alias gffs="git flow feature start"
alias gfff="git flow feature finish"

# tmux
alias tmuxk="tmux kill-session -t"
alias tmuxl="tmux list-session -F #S"

# xsel -> pbcopy
if [ -e "$(which xsel)" ]; then
    alias pbcopy="xsel -bi"
    alias pbpaste="xsel -bo"
fi

#---[tmuxd]---------------------------------------------------------------------
function tmuxd {
    local td_dir="$(realpath ${1:-$(pwd)})"
    local td_name="$(basename "$td_dir" | tr -d '.')"
    tmux new -d -s"$td_name" -c"$td_dir"
    # layouting
    local td_rc="$td_dir/.tmuxrc"
    if [ -e "$td_rc" ]; then
        sed "s/^\([a-z0-9-]\+\)/tmux \1 -t $td_name/i" "$td_rc" |
        env INIT_DIR="$td_dir" sh
    fi
}

#---[python venv wrapper]-------------------------------------------------------
[ -n "$VIRTUAL_ENV" ] && source "$VIRTUAL_ENV/bin/activate"

function venv {
    # TODO: pass other arguments ($@)
    [ ! -d "./venv" ] && virtualenv $@ "venv"
    source "./venv/bin/activate"
}

function vim {
    echo "porcodio usa nvim" | cowsay -f stegosaurus
}
