# Super user
alias _='sudo'
compdef _sudo _=sudo

# grep '#m' fix
#grep() { `/usr/bin/which grep` $@ | sed 's/#m//g' }

# Ruby/RVM stuff
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
#thin
stop-thin() { kill -INT `cat tmp/pids/thin.pid` }
thin-log() { tail -n0 -f log/thin.log }
#slant reload app
function ops-restart() {
    for app in "$@"; do
        sudo su - ops -c "mkdir -p ~/ops/$app/tmp && touch ~/ops/$app/tmp/restart.txt"
    done
}
function ops-pull-restart() {
    for app in "$@"; do
        sudo su - ops -c "cd ~/ops/$app && git pull && mkdir -p ~/ops/$app/tmp && touch ~/ops/$app/tmp/restart.txt"
    done
}

# Global aliases
alias -g VM='/var/log/messages'
alias -g VP='/var/log/puppet/puppet.log'

# My useful aliases
alias sysmon='echo "USER       PID %CPU %MEM  COMMAND" && "ps" aux | tail | cut -c1-25,65- | sort -n -k3'
function serv() { sudo /sbin/service $1 $2; }
function start() { serv $1 start; }
function stop() { serv $1 stop; }
function restart() { serv $1 restart; }
function status() { serv $1 status; }
function reload() { serv $1 reload; }
alias corn='sudo kill -INT `ps aux|grep "^root.*unicorn master"|awk -F" " "{print \\$2}"` && rvmsudo unicorn -p 80 -D config.ru start'
alias dd='tmux detach'
alias ns='sudo netstat -ntp'
alias nsl='sudo netstat -ntlp'
alias sync='~/.sync.sh'

# puppet
alias pp='time sudo puppetd -t'
alias pnoop='time sudo puppetd -t --noop'

# Yum aliases
alias y=yum
compdef _yum y=yum
alias Y='sudo yum'
alias yi='Y -y install'
alias ys='y search'
yqs() { yum list installed "*$1*" }
alias rql='rpm -ql'
alias yif='y info'
alias yr='Y -y remove'
alias rqo='rpm -qf'
whose() { rqo `which $1` }
compdef _which whose=which
#alias up='P -Syu'
alias ri='sudo rpm -ivh'

# paste stuff around
unalias pb
function pb() {
    cat << EOF > /tmp/pb.py
import sys
import urllib, urllib2

paste = sys.stdin.read().strip()

print urllib2.urlopen("http://pb.internal.directi.com/", urllib.urlencode({"name":"Viranch Mehta", "lang":"text", "code":paste, "submit":"submit"})).url.replace('view', 'view/raw')
EOF
    python /tmp/pb.py
}
function ccpb() {
    (echo "\$ $@" && $@) | pb
}
alias lpb='nc -l 10000'
ppb() { nc $1 10000 | pb }
compdef _ssh ppb=ssh
# ls colors
autoload colors; colors;

# Find the option for using colors in ls, depending on the version: Linux or BSD
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'

#setopt no_beep
setopt auto_cd
setopt multios
setopt cdablevarS

if [[ x$WINDOW != x ]]
then
    SCREEN_NO="%B$WINDOW%b "
else
    SCREEN_NO=""
fi

# Apply theming defaults
#PS1="%n@%m:%~%# "

# Setup the prompt with pretty colors
setopt prompt_subst

# Load the theme
PROMPT='%{$fg_bold[green]%}%M%{$reset_color%} %{$fg_bold[cyan]%}%c%{$reset_color%} %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}% » '
ZSH_THEME_GIT_PROMPT_PREFIX="<%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%} %{$fg[yellow]%}✗%{$fg[green]%}> %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}> "

export PATH=$PATH:$HOME/.rvm/bin:/usr/sbin:/sbin # Add RVM to PATH for scripting
export PATH=$PATH:/usr/lib64/nagios/plugins:/usr/lib64/nagios/plugins/custom # Add nagios plugins path to PATH
