#!/bin/sh

if test ! $(which brew); then
    echo "Installing linuxbrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
fi

echo -e "\n\nInstalling linuxbrew packages..."
echo "=============================="

formulas=(
    ack
    awscli
    git
    'grep --with-default-names'
    markdown
    neovim
    node
    the_silver_searcher
    tmux
    tree
    wget
    z
    zsh
    ripgrep
    git-standup
    entr
    exa
    go
    httpie
    python
    python3
    stow
    zsh-completions
)

for formula in "${formulas[@]}"; do
    if brew list "$formula" > /dev/null 2>&1; then
        echo "$formula already installed... skipping."
    else
        brew install $formula
    fi
done