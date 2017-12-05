# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

###-tns-completion-start-###
if [ -f $HOME/.tnsrc ]; then
    source $HOME/.tnsrc
fi
###-tns-completion-end-###

# Exports for oh-my-zsh Plugins
export VIRTUALENVWRAPPER_PYTHON='/usr/local/bin/python3'
VIRTUALENV_PYTHON='/usr/local/bin/python3'
VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
WORKON_HOME=$HOME/.virtualenvs

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh


# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="spaceship"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Would you like to use another custom folder than $ZSH/custom?
#ZSH_CUSTOM=$HOME/Projects/dotfiles/oh-my-zsh/custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colored-man colorize github jira vagrant virtualenv virtualenvwrapper pip pyenv python brew osx zsh-syntax-highlighting docker)

source $ZSH/oh-my-zsh.sh

command_exists () {
    type "$1" &> /dev/null ;
}

git-shorten-url() {
    #do things with parameters like $1 such as
    curl -i https://git.io -F "url=$1"
}

#######
# User configuration
#######

#Linux brew
if test -d /home/linuxbrew; then
    test -d ~/.linuxbrew && PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"
    test -d /home/linuxbrew/.linuxbrew && PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
    export PATH="$(brew --prefix)/bin:$(brew --prefix)/sbin:$PATH"
fi

# GOLang Things
export GOPATH=$HOME/golang
GOROOT=/usr/local/opt/go/libexec
GOBIN=$GOPATH/bin
PATH=$PATH:$GOBIN
PATH=$PATH:$GOPATH
PATH=$PATH:$GOROOT/bin
#######
# NPM things
#######
# this is the root folder where all globally installed node packages will  go
export NPM_PACKAGES="/usr/local/npm_packages"
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
PATH="$NPM_PACKAGES/bin:$PATH"

NVM_DIR="$HOME/.nvm"
test -d $NVM_DIR && . "/usr/local/opt/nvm/nvm.sh"

export PATH="/usr/local/opt/rubinius/bin:$PATH"
#######
# Python things
#######
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="/usr/local/lib:$PATH"

########
## Pyenv
########
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

##########
## autoenv
##########
# [ -f "$(brew --prefix autoenv)/activate.sh" ] && \
# source $(brew --prefix autoenv)/activate.sh

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Example aliases
alias zshconfig="code ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# shows in list format, follow symlinks colorized
# if command_exists exa; then
#     alias ls='exa -lGH'
# else
alias ls='ls -lGH'
# fi;

alias manpy='./manage.py'

# FullstackLabs Projects
alias siemens-pa-api='~/Projects/siemens-product-advisor-api'
alias siemens-pa-cms='~/Projects/siemens-product-advisor-cms'


# Spaceship theme modifications
SPACESHIP_KUBECONTEXT_SHOW=false
SPACESHIP_BATTERY_SHOW=false

###-tns-completion-start-###
if [ -f $HOME/.tnsrc ]; then
    source $HOME/.tnsrc
fi


###-tns-completion-end-###

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f $HOME/.npm-global/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . $HOME/.npm-global/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f $HOME/.npm-global/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . $HOME/.npm-global/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

echo "\e[2mzsh sourced"
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
