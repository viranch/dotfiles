# shipped with oh-my-zsh
alias history='fc -l 1'
alias l='ls -lh'
alias ll='ls -lha'
alias x=extract
alias afind='ack-grep -il'

# one liners
cutd() { cut -d $1 -f $2 }
awkp() { awk "{print \$$1}" }

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
alias -g WG='| swget -ci -'
alias -g Cd='| cutd'
alias -g Cc='| cut -c'
alias -g A='| awkp'

# My useful aliases
alias wget='wget --read-timeout=10'
alias swget='swget --read-timeout=10'
alias aa='axel' # very tidious to type a-x-e-l
alias ax='axel -a -n8'
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
alias gg='sudo grep --color=auto'
alias gr='gg -inr'
alias mcat='sudo tail -n +1' # multicat
alias cpb='curl -si http://pb/ --data-urlencode "name=Viranch Mehta" -d lang=text --data-urlencode code@- -d submit=submit | grep "Location: " | cut -d":" -f2- | sed "s/\\r//g" | sed "s/view/view\/raw/g"'
alias pb=cpb
ccpb() { (echo "\$ $@" && $@) | pb }
ff() { sudo find $2 -name $1 }
alias cf='cat << EOF'
alias cal='cal -3'
alias e='echo' # :)
alias cdr='cd ~/Work/repos'
#alias sudo='sudo ' # awesome trick to use aliases with sudo # doesn't fucking work with nocorrect
du() { /usr/bin/du -sh $@ | sort -rhk 1 }
alias nd='sudo ncdu -x'
alias df='df -h'
alias dfdev='df | grep --color=never "^\(Filesystem\|/dev/\)"'
alias tm='tmux attach || tmux'
alias confcat='grep -v -e "^$" -e "^\s*#"'
# kill stuff
alias kint='sudo killall -INT'
alias int='sudo kill -INT'
alias cont='sudo kill -CONT'
alias term='sudo kill -TERM'
alias kll='sudo kill -KILL'
# ssh
alias ss=ssh
alias ssw='ssh -i ~/.ssh/id_rsa-work' # ssh using work identity
ssd() { user=$1; shift; ssh $user.directi.com $@ }
ssi() { user=$1; shift; ssd $user.internal $@ }
ssfree() { ssh $1 'free -m' }
ssdf() { ssh $1 'df -h' }
# edit rc's
alias cdd='cd ~/.dotfiles'
alias vimrc='vim ~/.vimrc'
alias zshrc='vim ~/.zshrc && . ~/.zshrc'
alias gitconfig='vim ~/.gitconfig'
alias sshconfig='vim ~/.ssh/config'
alias sz='. ~/.zshrc'
dk() { host=$1; shift; docker -H $host:4321 $@; }
# fun
alias fucking=sudo

function chpwd() {
  emulate -L zsh
  /bin/ls
  find -maxdepth 1 -name .\*.zsh | while read f; do source $f; done
}

precmd() { test -n "$TMUX" && tmux rename-window -t $TMUX_PANE "`basename $PWD | cut -c -20`" }

# Dev aliases
alias h='vim `echo $_|sed "s/\.cpp/.h/g"`'
alias c='vim `echo $_|sed "s/\.h/.cpp/g"`'
alias lc='l *.cpp|awk "{ print \$9 }"|sed "s/\.cpp//g"'
alias m='make -j$((x+1))'
alias mi='sudo make install'
alias pmg='python manage.py'

# script aliases
SCRIPTS="$HOME/playground/scripts"
_fname() { find $SCRIPTS -name $1 }
alias imdb='python `_fname imdb.py`'
alias tv='`_fname tv.sh`'
