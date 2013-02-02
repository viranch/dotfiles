# Show history
alias history='fc -l 1'

# List direcory contents
alias lsa='ls -lah'
alias l='ls -lh'
alias ll='ls -la'
alias sl=ls # often screw this up

alias afind='ack-grep -il'

alias x=extract

# My useful aliases
alias wget='wget --read-timeout=10'
alias swget='swget --read-timeout=10'
alias axel='axel -a'
alias wv='sudo wvdial'
alias utube='youtube-dl -ct'
alias d='DISPLAY=:0'
alias v='vim'
alias sp="curl -s -F 'sprunge=<-' http://sprunge.us/"
alias sv='SUDO_EDITOR=vim sudoedit' #sudo vim
alias pg='ps aux | grep'
alias dig='dig +short'
# kill stuff
alias kint='killall -INT'
alias int='sudo kill -INT'
alias cont='sudo kill -CONT'
alias term='sudo kill -TERM'
alias kll='sudo kill -KILL'
# ssh
alias ss='ssh'
ssd() { user=$1; shift; ssh viranch.m@$user.directi.com $@ }
# edit rc's
alias cdd='cd ~/.dotfiles'
alias vimrc='vim ~/.vimrc'
alias zshrc='vim ~/.zshrc && . ~/.zshrc'
alias gitconfig='vim ~/.gitconfig'
alias sshconfig='vim ~/.ssh/config'
alias s='. ~/.zshrc'

function chpwd() {
  emulate -L zsh
  /bin/ls
}

# Dev aliases
alias h='vim `echo $_|sed "s/\.cpp/.h/g"`'
alias c='vim `echo $_|sed "s/\.h/.cpp/g"`'
alias lc='l *.cpp|awk "{ print \$9 }"|sed "s/\.cpp//g"'
alias m='make -j$((x+1))'
alias mi='sudo make install'
