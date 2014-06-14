#!/bin/bash

DOT_FILES=(.vim .vimrc .bashrc .gitconfig .zshrc .gemrc .tmux.conf .oh-my-zsh .ctags)

for file in ${DOT_FILES[@]}; do
    if [ ! -e  $HOME/$file ]; then
        ln -s $HOME/dotfiles/$file $HOME/$file
    fi
done

if [ ! -e =~/.git_template/]; then
    mkdir -p ~/.git_template/hooks
fi

if [ ! -e ~/.vim/autoload/pathogen.vim ]; then
    curl -Sso ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
fi

if [ ! -e ~/.vim/snipmate-snippets/neosnippets ]; then
    cd ~/.vim/snipmate-snippets && git clone https://github.com/Shougo/neosnippet-snippets.git
fi
