# Path to your oh-my-zsh configuration.
#ZSH=$HOME/.oh-my-zsh
export ZSH="/Users/shoyamas/.oh-my-zsh"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="pygmalion"
#ZSH_THEME="robbyrussell"

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
plugins=(git colorize history cp emoji-clock history-substring-search)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export GOPATH="${HOME}/.go"
export PATH="${GOPATH}/bin:${HOME}/bin:${PATH}"
export PATH=/Users/shoyamas/miniconda3/bin:$PATH
#export PATH=/Users/shoyamas/graalvm/Contents/Home/bin:$PATH
#export PATH=/Users/shoyamas/graalvm/Contents/Home/jre/languages/js/bin:$PATH
export PATH=/usr/local/Cellar/ruby/2.5.1/bin/:$PATH

########################################
# 環境変数
export LANG=ja_JP.UTF-8


# 色を使用出来るようにする
autoload -Uz colors
colors

# vim風キーバインドにする
#bindkey -v

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

#alias diff="colordiff"

alias ku="kubectl"
alias bp="bpctl"

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

#重複履歴を無視, 空白から始めたコマンドを無視 
export HISTCONTROL=ignoreboth


#--------------------------------
# read local settings
#--------------------------------
if [ -f ~/.zshrc.local ]; then
   source ~/.zshrc.local
fi

function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

_peco_mdfind() {
  open "$(mdfind -onlyin ~/ -name $@ | peco)"
}
alias s="_peco_mdfind"

function peco-cd()
{
    local var
    local dir
    if [ ! -t 0 ]; then
    var=$(cat -)
    dir=$(echo -n $var | peco)
    else
        return 1
    fi

    if [ -d "$dir" ]; then
        cd "$dir"
    else
        echo "'$dir' was not directory." >&2
        return 1
    fi
}

function peco-open()
{
    local var
    local file
    local command="vim"
    if [ ! -t 0 ]; then
        var=$(cat -)
        file=$(echo -n $var | peco)
    else
        return 1
    fi

    if [ -n "$1" ]; then
      command="$1"
    fi

    if [ -e "$file" ]; then
        # eval "$command $file"
        sh -c "vim $file < /dev/tty"
    else
        echo "Could not open '$file'." >&2
        return 1
    fi
}

# リポジトリに移動するコマンド
alias repocd='cd `ghq list -p | peco`'
# githubに移動するコマンド
alias ghopen='open "https://$(ghq list | peco)"'

man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
