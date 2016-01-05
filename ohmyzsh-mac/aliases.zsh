alias wget='swget -v'
alias qm='qmake -spec macx-g++'
alias o='open'
alias or='open -R'
alias sv='sudo vim'
alias ns='sudo netstat -nap tcp'
alias ipp='ifconfig en0 | grep "inet " | awk "{print \$2}"'
du() { /usr/bin/du -sh $@ | gsort -rhk 1 } # install gsort with brew install coreutils

# home brew
alias b='brew'
alias bs='brew search'
alias bi='brew install'
alias bif='brew info'
alias bl='brew list'
