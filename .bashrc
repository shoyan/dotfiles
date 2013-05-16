# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

function authme {
  ssh $1 'cat >>.ssh/authorized_keys' < ~/.ssh/id_rsa.pub
}

# Gitのカレントブランチを取得
function cb {
    echo "$(git branch | grep -e '^*' | sed "s/^*//g")"
}

# カレントブランチをリモートにpush
function push {
    CURRENT_BRANCH=$(cb);git push origin $CURRENT_BRANCH; unset CURRENT_BRANCH
}

function seika {
    URL="$(git remote -v | head -n 1 | sed -e 's|.*git@\(.*\):\(.*\)\.git.*|https://\1/\2|g')"; git log --pretty="%s \n $URL/commit/%H" --author="Shohei Yamasaki" --since=1.days | sed 's/\\n/\
/g'; unset URL
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

alias g="git"
alias ga="git add"
alias gs="git status"
alias gb="git branch"
alias pull="git pull"

#重複履歴を無視, 空白から始めたコマンドを無視 
export HISTCONTROL=ignoreboth

#よく使うコマンドは保存しない
export HISTIGNORE="fg*:bg*:history*:h:ls*:up"

export HISTSIZE=10000

#--------------------------------
# read local settings
#--------------------------------
if [ -f ~/.bashrc.local ]; then
   source ~/.bashrc.local
fi
