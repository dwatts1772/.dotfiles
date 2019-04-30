#! /etc/bash

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export HISTSIZE=1000
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=1000

###-tns-completion-start-###
if [ -f $HOME/.tnsrc ]; then
    source $HOME/.tnsrc
fi
###-tns-completion-end-###

# Exports for oh-my-zsh Plugins
export VIRTUALENVWRAPPER_PYTHON=`where python3` #'/usr/local/bin/python3'
VIRTUALENV_PYTHON=`where python3` #'/usr/local/bin/python3'
VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
WORKON_HOME=$HOME/.virtualenvs

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
ohmyzshplugins=(
    git \
    colored-man \
    colorize \
    github \
    # pip \
    # pyenv \
    # python \
    brew \
    osx \
    zsh-syntax-highlighting \
    zsh-autosuggestions \
    bgnotify \
    # iterm2 \
    docker
)
githubplugins=("MichaelAquilina/zsh-you-should-use")

# ZPlug stuff
export ZPLUG_HOME=/usr/local/opt/zplug
if test -d $ZPLUG_HOME; then
    source $ZPLUG_HOME/init.zsh
    # load oh-my-zsh plugins
    for plugin in "${ohmyzshplugins[@]}"
    do
        zplug "plugins/$plugin", from:oh-my-zsh
    done
    # load github plugins
    for plugin in "${githubplugins[@]}"
    do
        zplug $plugin
    done
    
    if ! zplug; then
        zplug install
    fi
    
    zplug load
fi

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="spaceship"
ZSH_THEME="powerlevel9k/powerlevel9k"

source ~/.powerlevelrc

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
#plugins=(git colored-man colorize github pip pyenv python brew osx zsh-syntax-highlighting docker)

source $ZSH/oh-my-zsh.sh

command_exists () {
    type "$1" &> /dev/null ;
}

git-shorten-url() {
    #do things with parameters like $1 such as
    curl -i https://git.io -F "url=$1"
}

gitremovelocalbranches(){
    git fetch -p && for branch in `git branch -vv | grep ': gone]' | awk '{print $1}'`; do git branch -D $branch; done
}

updatedotfiles(){
    cp ~/.zshrc ~/Projects/dotfiles/zsh/.zshrc
    cp ~/.powerlevelrc ~/Projects/dotfiles/zsh/.powerlevelrc
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

export PATH="/usr/local/opt/rubinius/bin:$PATH"
#######
# Python things
#######
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="/usr/local/lib:$PATH"

########
## Pyenv
########
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

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

#########
# Android
#########
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export ANDROID_HOME=/usr/local/share/android-sdk
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export ANDROID_NDK_HOME=/usr/local/share/android-ndk
export ANT_HOME=/usr/local/share/ant
export MAVEN_HOME=/usr/local/share/maven
export GRADLE_HOME=/usr/local/share/gradle

export PATH=$ANT_HOME/bin:$PATH
export PATH=$MAVEN_HOME/bin:$PATH
export PATH=$GRADLE_HOME/bin:$PATH
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/build-tools/19.1.0:$PATH

export PATH=/opt/local/bin:/opt/local/sbin:$PATH

#########
# GITHUB
#########
export GITHUB_TOKEN=944a89479e807009b47d4644cf8403ec4f8570ac

# Example aliases
alias zshconfig="code ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# shows in list format, follow symlinks colorized
# if command_exists exa; then
#     alias ls='exa -lGH'
# else
alias ls='ls -lGH'
# fi;

alias mpy='./manage.py'
alias manpy='./manage.py'
alias mpyserver='manpy server'

# FullstackLabs Projects
alias siemens-pa-api='~/Projects/siemens-product-advisor-api'
alias siemens-pa-cms='~/Projects/siemens-product-advisor-cms'
alias spacemx-client='~/Projects/SpaceMX/spacemx-client'
alias spacemx-api='~/Projects/SpaceMX/spacemx-api'
alias temp-spacemx-client='~/Projects/SpaceMX/_tempRepos/temp-spacemx-client'
alias temp-spacemx-api='~/Projects/SpaceMX/_tempRepos/temp-spacemx-api'

#alias gitremovelocalbranches='git branch --merged >/tmp/merged-branches && micro /tmp/merged-branches && xargs git branch -d </tmp/merged-branches'

alias c.="code ."
alias y="yarn"
alias ys="yarn start"
alias yys="yarn && yarn start"
alias yt="yarn test"
alias nvmu="nvm use"
alias cryptoart="cd ~/Development/cryptoart"

# Spaceship theme modifications
SPACESHIP_KUBECONTEXT_SHOW=false
SPACESHIP_BATTERY_SHOW=false

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f $HOME/.npm-global/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . $HOME/.npm-global/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f $HOME/.npm-global/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . $HOME/.npm-global/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

export NVM_DIR="$HOME/.nvm"
NVM_DIR="$HOME/.nvm"
test -d $NVM_DIR && . "/usr/local/opt/nvm/nvm.sh"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"
    
    if [ -n "$nvmrc_path" ]; then
        local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
        
        if [ "$nvmrc_node_version" = "N/A" ]; then
            nvm install
            elif [ "$nvmrc_node_version" != "$node_version" ]; then
            nvm use
        fi
        elif [ "$node_version" != "$(nvm version default)" ]; then
        echo "Reverting to nvm default version"
        nvm use default
    fi
}
add-zsh-hook chpwd load-nvmrc
#load-nvmrc

# Slack black theme (https://github.com/caiceA/slack-black-theme/)
slackBlackTheme(){
    local blackThemeURL="https://raw.githubusercontent.com/caiceA/slack-black-theme/master/ssb-interop.js"
    local slackLocation="/Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static"
    local interopFile="ssb-interop.js"
    local interopFileBackup="ssb-interop.js.backup"
    
    echo "Copying slack interop file..."
    sudo cp "$slackLocation/$interopFile" "$slackLocation/$interopFileBackup"
    
    echo "Downloading latest slack black theme interop file..."
    sudo curl -o "$slackLocation/$interopFile" "$blackThemeURL"

    echo "Closing Slack..."
    killall Slack
    while pgrep -u root Slack > /dev/null; do sleep 1; done
    
    echo "Launching Slack..."
    open -a Slack
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

echo "\e[2mzsh sourced"
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/davidwatts/Projects/SpaceMX/spacemx-sitemap-generator/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/davidwatts/Projects/SpaceMX/spacemx-sitemap-generator/node_modules/tabtab/.completions/slss.zsh
