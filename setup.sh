#!/bin/bash

DOT_FILES=(.vim .vimrc .bashrc .gitconfig .zshrc .gemrc .tmux.conf .oh-my-zsh .git_template .ctags)

for file in ${DOT_FILES[@]}; do
    if [ ! -e  $HOME/$file ]; then
        ln -s $HOME/dotfiles/$file $HOME/$file
    fi
done


if [ ! -e ~/.vim/autoload/pathogen.vim ]; then
    curl -Sso ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
fi
