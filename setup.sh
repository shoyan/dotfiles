#!/bin/bash

DOT_FILES=(.vim .vimrc .bashrc .gitconfig .zshrc .gemrc .tmux.conf .oh-my-zsh)

for file in ${DOT_FILES[@]}; do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

curl -Sso ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

