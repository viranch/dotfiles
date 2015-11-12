# Super user
alias _='sudo'
compdef _sudo _=sudo

# grep '#m' fix
#grep() { `/usr/bin/which grep` $@ | sed 's/#m//g' }

# Ruby/RVM stuff
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

PATH=$PATH:$HOME/bin
#bundle
alias bi='bundle install'

function ipp() {
    netstat -i | tail -n+3 | awk '{print $1}' | grep -v "^lo$" | while read dev; do
        ip=`ifconfig $dev | grep "inet[^6]" | awk '{print $2}' | cut -d':' -f2`
        test -n "$ip" && echo "$dev: $ip"
    done
}

# Global aliases
alias -g VM='/var/log/messages'
alias -g VP='/var/log/puppet/puppet.log'

# init service aliases
alias service='sudo service'
function start() { service $1 start; }
function stop() { service $1 stop; }
function restart() { service $1 restart; }
function status() { service $1 status; }
function reload() { service $1 reload; }
compdef _service start=service
compdef _service stop=service
compdef _service restart=service
compdef _service status=service
compdef _service reload=service

# My useful aliases
alias sysmon='echo "USER       PID %CPU %MEM  COMMAND" && "ps" aux | tail | cut -c1-25,65- | sort -n -k3'
alias corn='sudo kill -INT `ps aux|grep "^root.*unicorn master"|awk -F" " "{print \\$2}"` && rvmsudo unicorn -p 80 -D config.ru start'
alias dd='tmux detach'
alias ns='sudo netstat -ntp'
alias nsl='sudo netstat -ntlp'
alias sync='~/.sync.sh'
fc() { test -z "$1" && sudo facter || sudo facter -p "$1" }
alias whereami='fc colo'
alias su='sudo '
alias ii='sudo su icinga'

# puppet
alias pp='time sudo puppetd -t'
alias pnoop='time sudo puppetd -t --noop'
alias check_yamls="ruby -e \"require 'yaml';  Dir['**/*.yaml'].select {|f| begin; YAML.load_file(f); rescue; puts f; raise; end }\""

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
alias which && unalias which # unalias only if aliased
whose() { rqo `which -p $1` }
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

print urllib2.urlopen("http://slant-infra.internal.directi.com:8088/api/create", urllib.urlencode({"name":"Viranch Mehta", "lang":"text", "text":paste})).read()
EOF
    python /tmp/pb.py | sed 's/view/view\/raw/g'
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
unset SSH_ASKPASS

function share() {
    temp="/tmp/myshare-$RANDOM"
    mkdir -p $temp
    for f in "$@"; do
        ln -s "$(readlink -e $f)" "$temp/$(basename $f)"
    done
    cd $temp
    python -m SimpleHTTPServer
    cd -
    rm -rf $temp
}
