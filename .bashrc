# User add alias
alias ls='ls -F -G'
alias la='ls -a'
alias ll='ls -l'
alias h='history'

alias up='cd ../'
alias upp='cd ../../'

function authme {
  ssh $1 'cat >>.ssh/authorized_keys' < ~/.ssh/id_rsa.pub
}
