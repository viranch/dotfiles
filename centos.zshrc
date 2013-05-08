# Super user
alias _='sudo'
compdef _sudo _=sudo

# grep '#m' fix
grep() { `/usr/bin/which grep` $@ | sed 's/#m//g' }

# Global aliases
alias -g VM='/var/log/messages'
alias -g VP='/var/log/puppet/puppet.log'

# My useful aliases
alias sysmon='echo "USER       PID %CPU %MEM  COMMAND" && "ps" aux | tail | cut -c1-25,65- | sort -n -k3'
function serv() { sudo /sbin/service $1 $2; }
function start() { sudo /sbin/service $1 start; }
function stop() { sudo /sbin/service $1 stop; }
function restart() { sudo /sbin/service $1 restart; }
alias corn='sudo kill -INT `ps aux|grep "^root.*unicorn master"|awk -F" " "{print \\$2}"` && rvmsudo unicorn -p 80 -D config.ru start'

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

# nagios puppet related stuff
puppet_process="/usr/bin/ruby /usr/bin/puppet apply "
alias ps-puppet='ps aux | grep "$puppet_process" | grep -v grep'
puppet_user() { test -n "$(ps-puppet)" && who | grep "$(ps-puppet|head -n1|awk '{print $7}') " | cut -d" " -f1; }
alias puppet-apply='test -n "$(puppet_user)" && echo && echo "WARNING: $(puppet_user) is already running puppet" && echo || (cd /etc/puppet/ && sudo git pull && cd - && time sudo /usr/bin/puppet apply /etc/puppet/manifests/production/site.pp --config /etc/puppet/usermode.conf --verbose)'
alias ntest='sudo service nagios configtest | grep -v "^Processing object config file "'
alias nload='sudo service nagios reload'
alias tc='su nagios -c'

function pb() {
    cat > /tmp/pb.py << EOF
import sys
import urllib, urllib2

paste = sys.stdin.read()

print urllib2.urlopen("http://pb.internal.directi.com/", urllib.urlencode({"name":"Viranch Mehta", "lang":"text", "code":paste, "submit":"submit"})).url
EOF
    python /tmp/pb.py
    rm -f /tmp/pb.py
}
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
