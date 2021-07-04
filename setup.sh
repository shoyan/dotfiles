#!/bin/bash

DOT_FILES=(.vimrc .bashrc .gitconfig .zshrc .gemrc .tmux.conf .gitignore_global)

for file in ${DOT_FILES[@]}; do
    if [ ! -e  $HOME/$file ]; then
        ln -s $HOME/dotfiles/$file $HOME/$file
    fi
done

if [ ! -e $HOME/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ ! -x /usr/local/bin/brew ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi


if [ ! -x /usr/local/bin/peco ]; then
    brew install peco
fi

if [ ! -x /usr/local/bin/ghq ]; then
    brew install ghq
fi