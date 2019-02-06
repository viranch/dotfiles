# Global aliases
alias -g VM='/var/log/messages'
alias -g VP='/var/log/puppet/puppet.log'

# systemctl
alias sys='sudo systemctl'
alias start='sys start'
alias stop='sys stop'
alias restart='sys restart'
alias reload='sys reload'
alias status='sys status'
alias senable='sys enable'
alias sdisable='sys disable'
alias sys-reload='sys daemon-reload'

# My useful aliases
alias sysmon='echo "USER       PID %CPU %MEM  COMMAND" && "ps" aux | tail | cut -c1-25,65- | sort -n -k3'
alias corn='sudo kill -INT `ps aux|grep "^root.*unicorn master"|awk -F" " "{print \\$2}"` && rvmsudo unicorn -p 80 -D config.ru start'
alias dd='tmux detach'
alias ns='sudo netstat -ntp'
alias nsl='sudo netstat -ntlp'
alias sync='~/.sync.sh'
# fc() { test -z "$1" && sudo facter || sudo facter -p "$1" }
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
alias which >/dev/null && unalias which # unalias only if aliased
whose() { rqo `which -p $1` }
compdef _which whose=which
alias ri='sudo rpm -ivh'

# paste stuff around
alias rpb='nc -l 10000'
wpb() { nc $1 10000 }

# svn stuff
unalias sd
sd() { svn diff $@ }
compdef _svndiff sd=svndiff
sc() { svn ci -m $@ }
compdef _svndiff sc=svndiff
st() { svn status $@ }
compdef _svndiff st=svndiff
