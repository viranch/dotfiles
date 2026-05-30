# completion init
autoload -U compinit
compinit -i
zmodload -i zsh/complist

# shipped with oh-my-zsh
alias history='fc -l 1'
alias l='ls -lhN'
alias ll='ls -lhaN'
alias x=extract

# one liners
cutd() { cut -d $1 -f $2 }
awkp() { awk "{print \$$1}" }

# Global aliases
alias -g C='| wc -l'
alias -g G='| grep'
alias -g H='| head'
alias -g L='| less'
alias -g S='| sort'
alias -g U='| uniq -c | sort -nrk 1'
alias -g SU='S U'
alias -g HH='--help | less -F'
alias -g WW='| while read p; do'
alias -g WG='| swget -ci -'
alias -g Cd='| cutd'
alias -g A='| awkp'
alias -g XX='-print0 | xargs -0'
alias -g DF="| sed 's/^-\\([^-]*\\)/\\x1b[31;1m-\\1/;s/^+\\([^+]*\\)/\\x1b[32;1m+\\1/;s/^@/\\x1b[36;1m@/;s/$/\\x1b[0m/' | less -SRF"
alias -g JJ='| jq -C . | less -SR'
alias -g AV='| awk "{ total += \$1; count++ } END { print total/count }"'

# Make folks talk
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'

# My useful aliases
alias wget='wget --read-timeout=10'
alias aa='axel' # very tidious to type a-x-e-l
alias ax='axel -a -n8'
alias utube='youtube-dl -c'
alias rsync='rsync --append -zh --progress'
alias v=vim
alias sv='SUDO_EDITOR=vim sudoedit' #sudo vim
compdef _vim sv=sudoedit
#alias pg='ps aux | grep'
pg() { ps aux | grep --color=always $* | grep -vw "grep" }
alias digs='dig +short'
alias digns='dig +short +noshort'
alias tf='tail -f'
alias gg='grep --color=auto'
alias gr='gg -inr'
alias mcat='tail -n +1' # multicat
ff() { find ${2:-.} -name $1 }
alias cf='cat << EOF'
alias cal='cal -3'
alias e='echo' # :)
alias pwf='readlink -f'
#alias sudo='sudo ' # awesome trick to use aliases with sudo # doesn't fucking work with nocorrect
du() { /usr/bin/du -sh $@ | sort -rhk 1 }
alias nd='sudo ncdu -x'
alias df='df -h | grep --color=never "^\(Filesystem\|/dev/\|\S\+:\)"'
alias ctc='grep -v -e "^$" -e "^\s*#"'
alias curld='curl -Sso /dev/null -D-'
alias curlv='curl -Sso /dev/null -v'
alias py=python3
alias wpy='which python3'
# kill stuff
alias kint='sudo kill -INT'
alias kterm='sudo kill -TERM'
alias k9='sudo kill -KILL'
compdef _kill kint=kill
compdef _kill kterm=kill
compdef _kill k9=kill
# ssh
alias ss=ssh
# edit rc's
alias cdd='cd ~/.dotfiles'
alias vimrc='vim ~/.vimrc'
alias zshrc='vim ~/.zshrc && exec /bin/zsh'
alias gitconfig='vim ~/.gitconfig'
alias sshconfig='vim ~/.ssh/config'
alias ee='exec zsh'

function chpwdls() {
  /bin/ls --color=tty
}

function chpwd() {
  emulate -L zsh
  chpwdls
  find . -maxdepth 1 -name .\*.zsh | while read f; do source $f; done
  find . -maxdepth 1 -type d | while read d; do test -f $d/bin/activate && source $d/bin/activate && break; done || deactivate 2>/dev/null
}

precmd() { test -n "$TMUX_PANE" && tmux rename-window -t $TMUX_PANE "`basename $PWD | cut -c -20`" }

# Dev aliases
alias wgst='wget https://mirrors.xtom.com/archlinux/iso/latest/archlinux-x86_64.iso -O/dev/null -nv --show-progress'
alias curlst='curl -o/dev/null -r 0-300000000 https://mirrors.xtom.com/archlinux/iso/latest/archlinux-x86_64.iso'
alias speedtest=wgst
