# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="pygmalion"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH="${HOME}/.rbenv/bin:${HOME}/.rbenv/shims:${HOME}/bin:${PATH}"
export PATH=$PATH:/usr/local/mysql/bin
eval "$(rbenv init -)"

########################################
# 環境変数
export LANG=ja_JP.UTF-8


# 色を使用出来るようにする
autoload -Uz colors
colors

# emacs 風キーバインドにする
bindkey -e

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# 補完
# 補完機能を有効にする
autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# = の後はパス名として補完する
setopt magic_equal_subst

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# ヒストリファイルに保存するとき、すでに重複したコマンドがあったら古い方を削除する
setopt hist_save_nodups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 補完候補が複数あるときに自動的に一覧表示する
setopt auto_menu

# 高機能なワイルドカード展開を使用する
setopt extended_glob

########################################
# キーバインド

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward

bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

########################################
# エイリアス

alias la='ls -a'
alias ll='ls -l'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

alias du="du -h"
alias df="df -h"

alias up="cd ../"
alias upp="cd ../../"
alias h="history"

alias grep="grep --color --exclude='tags' --exclude='*.svn-*'  --exclude='entries' --exclude='.git'"
alias be="bundle exec"

alias g="git"
alias ga="git add"
alias gs="git status"
alias gb="git branch"
alias pull="git pull"

alias v="vim"

alias ctags='/usr/local/Cellar/ctags/5.8/bin/ctags'

alias diff="colordiff"

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi



########################################
# OS 別の設定
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        #Linux用の設定
        alias ls='ls --color'
        ;;
esac

# vim:set ft=zsh:

function authme {
  ssh $1 'cat >>.ssh/authorized_keys' < ~/.ssh/id_rsa.pub
}

# Gitのカレントブランチを取得
function cb {
    echo "$(git rev-parse --abbrev-ref HEAD)"
}

# カレントブランチをリモートにpush
function push {
    CURRENT_BRANCH=$(cb);git push origin $CURRENT_BRANCH; unset CURRENT_BRANCH
}

function branch_clean {
    g branch --merged | grep -v \* | grep -v master | xargs -I % git branch -d %
}

function seika {
    local URL="$(git remote -v | head -n 1 | sed -e 's|.*git@\(.*\):\(.*\)\.git.*|https://\1/\2|g')"; git log --pretty="%s \n $URL/commit/%H" --author="$(git config --get user.name)" --since=1.days | sed 's/\\n/\
/g'
}

function compare {
    local CURRENT_BRANCH=$(cb);
    local REMOTE_URI="$(git remote -v)";

    if [[ "$REMOTE_URI" =~ "ghe" ]]; then
        open "$(git remote -v | head -n 1 | sed -e 's|.*http://\(.*\).git.*|http://\1/|g')compare/master...$CURRENT_BRANCH"
    else
        open "$(git remote -v | head -n 1 | sed -e 's|.*git@\(.*\):\(.*\)\.git.*|https://\1/\2|g')/compare/master...$CURRENT_BRANCH"
    fi
}


function hateb {
    curl -s --data '<?xml version="1.0"?><methodCall><methodName>bookmark.getTotalCount</methodName><params><param><value><string>http://shoyan.hatenablog.com/</string></value></param></params></methodCall>' http://b.hatena.ne.jp/xmlrpc | sed -e 's@.*<int>\(.*\)</int>.*@\1@'
}

# 時刻表
function jikoku {
    open "http://subway.city.fukuoka.lg.jp/schedule/eki_diagram.php?p1=0&p2=%E5%A4%A9%E7%A5%9E&p3=0&p4=0"
}

# ジブリのmusic
function jiburi {
    open "https://www.youtube.com/watch?v=xDAqQgWiAvE"
}

#重複履歴を無視, 空白から始めたコマンドを無視 
export HISTCONTROL=ignoreboth


#--------------------------------
# read local settings
#--------------------------------
if [ -f ~/.zshrc.local ]; then
   source ~/.zshrc.local
fi
