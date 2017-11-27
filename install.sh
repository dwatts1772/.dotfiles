#!/usr/bin/env bash

command_exists() {
    type "$1" > /dev/null 2>&1
}

echo "Installing dotfiles."

# only perform macOS-specific install
if [ "$(uname)" == "Darwin" ]; then
    echo -e "\n\nRunning on OSX"

    source install/homebrew.sh

    source install/osx.sh
else
    echo -e "\n\nRunning on Linux"

    source install/linuxbrew.sh
fi

if ! command_exists zsh; then
    echo "zsh not found. Please install and then re-run installation scripts"
    exit 1
elif ! [[ $SHELL =~ .*zsh.* ]]; then
    echo "Configuring zsh as default shell"
    chsh -s $(which zsh)
    if [ test ! -d ~/.oh-my-zsh ]; then
        echo "\n\nInstalling oh-my-zsh"
        sudo sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    fi
fi

echo "Done. Reload your terminal."