# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

###-tns-completion-start-###
if [ -f /Users/davidwatts/.tnsrc ]; then 
    source /Users/davidwatts/.tnsrc 
fi
###-tns-completion-end-###


# Path to your oh-my-zsh installation.
export ZSH=/Users/davidwatts/.oh-my-zsh


# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="spaceship"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/Projects/dotfiles/oh-my-zsh/custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colored-man colorize github jira vagrant virtualenv virtualenvwrapper pip python brew osx zsh-syntax-highlighting docker)

source $ZSH/oh-my-zsh.sh

# User configuration
# GOLang Things
export GOPATH=$HOME/golang
export GOROOT=/usr/local/opt/go/libexec
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH
export PATH=$PATH:$GOROOT/bin

# NPM things
# this is the root folder where all globally installed node packages will  go
export NPM_PACKAGES="/usr/local/npm_packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export PATH="$NPM_PACKAGES/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"

export PATH="/usr/local/opt/rubinius/bin:$PATH"

# Python things
export VIRTUALENVWRAPPER_PYTHON='/usr/local/bin/python3'
export VIRTUALENV_PYTHON='/usr/local/bin/python3'
export WORKON_HOME=$HOME/.virtualenvs

export PATH="/Users/davidwatts/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

source /usr/local/bin/virtualenvwrapper.sh

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# shows in list format, follow symlinks colorized
alias ls='ls -lGH'
alias manpy='./manage.py'

# FullstackLabs Projects
alias siemens-pa-api='~/Projects/siemens-product-advisor-api'
alias siemens-pa-cms='~/Projects/siemens-product-advisor-cms'


# Spaceship theme modifications
SPACESHIP_KUBECONTEXT_SHOW=false
SPACESHIP_BATTERY_SHOW=false

###-tns-completion-start-###
if [ -f /Users/davidwatts/.tnsrc ]; then 
    source /Users/davidwatts/.tnsrc 
fi


###-tns-completion-end-###

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/davidwatts/.npm-global/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/davidwatts/.npm-global/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/davidwatts/.npm-global/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/davidwatts/.npm-global/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion