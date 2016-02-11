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
alias -g H='| head'
alias -g L='| less'
alias -g S='| sort'
alias -g U='| uniq -c'
alias -g HH='--help | less'
alias -g WW='| while read p; do'
alias -g WG='| swget -ci -'
alias -g Cd='| cutd'
alias -g A='| awkp'
alias -g XX='-print0 | xargs -0'

# Make folks talk
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'

# My useful aliases
alias wget='wget --read-timeout=10'
alias swget='swget --read-timeout=10'
alias aa='axel' # very tidious to type a-x-e-l
alias ax='axel -a -n8'
alias utube='youtube-dl -c'
alias rsync='rsync --append -zh --progress'
alias v=vim
alias sp="curl -s -F 'sprunge=<-' http://sprunge.us/"
alias sv='SUDO_EDITOR=vim sudoedit' #sudo vim
#alias pg='ps aux | grep'
pg() { ps aux | grep $* | grep -vw "grep" | grep --color=auto $* }
vb() { vim `which $@` }
alias dig='dig +short'
alias tf='sudo tail -f'
alias sl='sudo less'
alias lr='sudo less -r'
alias gg='sudo grep --color=auto'
alias gr='gg -inr'
alias gnr='gg -nr'
alias mcat='sudo tail -n +1' # multicat
ff() { sudo find ${2:-.} -name $1 }
alias cf='cat << EOF'
alias cal='cal -3'
alias e='echo' # :)
alias pwf='readlink -f'
#alias sudo='sudo ' # awesome trick to use aliases with sudo # doesn't fucking work with nocorrect
du() { /usr/bin/du -sh $@ | sort -rhk 1 }
alias nd='sudo ncdu -x'
alias df='df -h | grep --color=never "^\(Filesystem\|/dev/\)"'
alias dfa='/usr/bin/df -h'
alias ctc='grep -v -e "^$" -e "^\s*#"'
alias chead='curl -D- -so /dev/null'
alias curlv='curl -svo /dev/null'
# kill stuff
alias kint='sudo kill -INT'
alias cunt='sudo kill -INT'
alias kcont='sudo kill -CONT'
alias kterm='sudo kill -TERM'
alias k9='sudo kill -KILL'
# ssh
alias ss=ssh
# edit rc's
alias cdd='cd ~/.dotfiles'
alias vimrc='vim ~/.vimrc'
alias zshrc='vim ~/.zshrc && . ~/.zshrc'
alias gitconfig='vim ~/.gitconfig'
alias sshconfig='vim ~/.ssh/config'
alias ee='exec zsh'
# docker
alias dc=docker
alias db='docker build -t'
alias dl='docker pull'
alias dp='docker push'
alias dim='docker images'
alias dimclean='docker rmi `docker images | grep "<none>" | awk "{print \$3}"`'
alias drmi='docker rmi'
alias drn='docker run --rm -it'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dpclean='docker rm `docker ps -a | tail -n +2 | grep -v " Up " | cut -d" " -f1`'
alias de='docker exec -it'
alias dll='docker logs -f'
alias din='docker inspect'
alias dstart='docker start'
alias dstop='docker stop'
alias drst='docker restart'
alias drm='docker rm'

function chpwd() {
  emulate -L zsh
  /bin/ls
  find . -maxdepth 1 -name .\*.zsh | while read f; do source $f; done
}

precmd() { test -n "$TMUX" && tmux rename-window -t $TMUX_PANE "`basename $PWD | cut -c -20`" }

# Dev aliases
alias m='make -j$((x+1))'
