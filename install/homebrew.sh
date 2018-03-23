#!/bin/sh

if test ! $(which brew); then
    echo "Installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo -e "\n\nInstalling homebrew packages..."
echo "=============================="

formulas=(
    ack
    awscli
    entr
    exa
    git
    git-standup
    go
    'grep --with-default-names'
    httpie
    markdown
    micro
    neovim
    node
    python
    python3
    ripgrep
    stow
    the_silver_searcher
    tmux
    tree
    wget
    z
    zplug
    zsh
    zsh-completions
)

for formula in "${formulas[@]}"; do
    if brew list "$formula" > /dev/null 2>&1; then
        echo "$formula already installed... skipping."
    else
        brew install $formula
    fi
done