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
    #echo "$(git branch | grep -e '^*' | sed "s/^*//g")"
    echo "$(git rev-parse --abbrev-ref HEAD)"
}

# カレントブランチをリモートにpush
function push {
    CURRENT_BRANCH=$(cb);git push origin $CURRENT_BRANCH; unset CURRENT_BRANCH
}

function seika {
    local URL="$(git remote -v | head -n 1 | sed -e 's|.*git@\(.*\):\(.*\)\.git.*|https://\1/\2|g')"; git log --pretty="%s \n $URL/commit/%H" --author="$(git config --get user.name)" --since=1.days | sed 's/\\n/\
/g'
}

function compare {
    local CURRENT_BRANCH=$(cb);
    open "$(git remote -v | head -n 1 | sed -e 's|.*git@\(.*\):\(.*\)\.git.*|https://\1/\2|g')/compare/master...$CURRENT_BRANCH"
}


function hateb {
    curl -s --data '<?xml version="1.0"?><methodCall><methodName>bookmark.getTotalCount</methodName><params><param><value><string>http://shoyan.hatenablog.com/</string></value></param></params></methodCall>' http://b.hatena.ne.jp/xmlrpc | sed -e 's@.*<int>\(.*\)</int>.*@\1@'
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
alias grep="grep --color --exclude='tags' --exclude='*.svn-*'  --exclude='entries' --exclude='.git'"
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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
