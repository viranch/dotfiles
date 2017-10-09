# Changing/making/removing directory
setopt auto_name_dirs
setopt auto_pushd
setopt pushd_ignore_dups

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'

alias 1='cd -'
alias 2='cd +2'
alias 3='cd +3'
alias 4='cd +4'
alias 5='cd +5'
alias 6='cd +6'
alias 7='cd +7'
alias 8='cd +8'
alias 9='cd +9'

alias md='mkdir -p'
alias smd='sudo mkdir -p'
alias d='dirs -v'

# mkdir & cd to it
function mcd() { 
  mkdir -p "$1" && cd "$1"; 
}
compdef _mkdir mcd=mkdir

function findup() {
    here=$PWD
    while test "$(basename $PWD)" != "$1"; do
        cd ..
        test "$PWD" = "/" && break
    done
    there=$PWD
    cd $here
    cd $there
    unset here there
    echo $PWD
}
alias fup=findup
