# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

function authme {
  ssh $1 'cat >>.ssh/authorized_keys' < ~/.ssh/id_rsa.pub
}

# User specific aliases and functions
alias ls='ls -F -G'
alias la="ls -a"
alias ll="ls -l"
alias du="du -h"
alias df="df -h"
alias up="cd ../"
alias upp="cd ../../"
alias rm="rm -i"
alias mkdir="mkdir -p"
alias h="history"
alias grep="grep --exclude='tags' --exclude='*.svn-*'  --exclude='entries'"
alias be="bundle exec"

#重複履歴を無視, 空白から始めたコマンドを無視 
export HISTCONTROL=ignoreboth

#よく使うコマンドは保存しない
export HISTIGNORE="fg*:bg*:history*:h:ls*:up"

export HISTSIZE=10000
