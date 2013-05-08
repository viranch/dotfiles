# shipped with oh-my-zsh
alias history='fc -l 1'
alias l='ls -lh'
alias ll='ls -lha'
alias x=extract
alias afind='ack-grep -il'

# Global aliases
alias -g C='| wc -l'
alias -g G='| grep'
alias -g GC='| grep -c'
alias -g H='| head'
alias -g HL='| head -n20'
alias -g L='| less'
alias -g S='| sort'
alias -g T='| tail'
alias -g TL='| tail -n20'
alias -g TF='| tail -f'

# My useful aliases
alias wget='wget --read-timeout=10'
alias swget='swget --read-timeout=10'
alias axel='axel -a'
alias wv='sudo wvdial'
alias utube='youtube-dl -ct'
alias v=vim
alias sp="curl -s -F 'sprunge=<-' http://sprunge.us/"
alias sv='SUDO_EDITOR=vim sudoedit' #sudo vim
alias pg='ps aux | grep'
alias dig='dig +short'
alias t=tail
alias tf='sudo tail -f'
alias st='sudo tail'
alias stf='sudo tail -f'
alias gg='sudo grep'
alias gr='gg -inr'
ff() { sudo find $2 -name $1 }
alias cf='cat << EOF'
# kill stuff
alias kint='sudo killall -INT'
alias int='sudo kill -INT'
alias cont='sudo kill -CONT'
alias term='sudo kill -TERM'
alias kll='sudo kill -KILL'
# ssh
alias ss=ssh
ssd() { user=$1; shift; ssh $user.directi.com $@ }
ssi() { user=$1; shift; ssd $user.internal $@ }
# edit rc's
alias cdd='cd ~/.dotfiles'
alias vimrc='vim ~/.vimrc'
alias zshrc='vim ~/.zshrc && . ~/.zshrc'
alias gitconfig='vim ~/.gitconfig'
alias sshconfig='vim ~/.ssh/config'
alias s='. ~/.zshrc'
# fun
alias fucking=sudo

function chpwd() {
  emulate -L zsh
  /bin/ls
}

precmd() { test -n "$TMUX" && tmux rename-window `basename "$(echo $PWD | sed 's/'$(echo $HOME | sed 's/\//\\\//g')'/~/g')"` }

# Dev aliases
alias h='vim `echo $_|sed "s/\.cpp/.h/g"`'
alias c='vim `echo $_|sed "s/\.h/.cpp/g"`'
alias lc='l *.cpp|awk "{ print \$9 }"|sed "s/\.cpp//g"'
alias m='make -j$((x+1))'
alias mi='sudo make install'
