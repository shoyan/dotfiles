#!/bin/bash

DOT_FILES=(.vim .vimrc .bashrc .gitconfig .zshrc .gemrc .tmux.conf .oh-my-zsh .git_template .ctags .gitignore_global)

for file in ${DOT_FILES[@]}; do
    if [ ! -e  $HOME/$file ]; then
        ln -s $HOME/dotfiles/$file $HOME/$file
    fi
done


if [ ! -e ~/.vim/autoload/pathogen.vim ]; then
    mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

if [ ! -e ~/.vim/bundle/vimproc.vim ]; then
    git clone https://github.com/Shougo/vimproc.vim.git ~/.vim/bundle/vimproc.vim
    cd ~/.vim/bundle/vimproc.vim
    make
fi
