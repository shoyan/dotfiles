#!/bin/bash

DOT_FILES=(.vimrc .bashrc .gitconfig .zshrc .gemrc)

for file in ${DOT_FILES[@]}; do
    ln -s $HOME/dotfiles/$file $HOME/$file
done
