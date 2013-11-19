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
alias -g U='| uniq -c'
alias -g T='| tail'
alias -g TL='| tail -n20'
alias -g TF='| tail -f'
alias -g HH='--help | less'
alias -g WW='| while read p; do'

# My useful aliases
alias wget='wget --read-timeout=10'
alias swget='swget --read-timeout=10'
alias aa='axel' # very tidious to type a-x-e-l
alias a='axel -a -n8'
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
alias sl='sudo less'
alias lr='sudo less -r'
alias gg='sudo grep'
alias gr='gg -inr'
alias cpb='curl -si http://pb/ --data-urlencode "name=Viranch Mehta" -d lang=text --data-urlencode code@- -d submit=submit | grep "Location: " | cut -d":" -f2- | sed "s/\\r//g" | sed "s/view/view\/raw/g"'
alias pb=cpb
ff() { sudo find $2 -name $1 }
alias cf='cat << EOF'
alias cal='cal -3'
alias e='echo' # :)
alias sudo='sudo ' # awesome trick to use aliases with sudo
alias du='du -sh'
alias df='df -h'
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

precmd() { test -n "$TMUX" && tmux rename-window "`basename $PWD | cut -c -20`" }

# Dev aliases
alias h='vim `echo $_|sed "s/\.cpp/.h/g"`'
alias c='vim `echo $_|sed "s/\.h/.cpp/g"`'
alias lc='l *.cpp|awk "{ print \$9 }"|sed "s/\.cpp//g"'
alias m='make -j$((x+1))'
alias mi='sudo make install'

# script aliases
SCRIPTS="$HOME/playground/scripts"
_fname() { find $SCRIPTS -name $1 }
alias imdb='python `_fname imdb.py`'
alias tv='`_fname tv.sh`'
