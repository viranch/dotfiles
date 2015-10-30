# If not running interactively, do not do anything
[[ $- != *i* ]] && return
[[ $TERM != screen* ]] && test -z "$TMUX" && (tmux attach || tmux new-session) && exit
#[[ $TERM != screen* ]] && test -z "$TMUX" && (tmux new-session) && exit

for i (~/.dotfiles/ohmyzsh-common/*.zsh) source $i
source ~/.dotfiles/centos.zshrc

function fixssh() {
  if [ -n "$TMUX" ] # set only if within running tmux
  then
    for key in SSH_AUTH_SOCK SSH_CONNECTION SSH_CLIENT; do
        if (tmux show-environment | grep "^${key}" > /dev/null); then
            #value=`tmux show-environment | grep "^${key}" | sed -e "s/^[A-Z_]*=//"`
            #export ${key}="${value}"
            export "`tmux show-environment | grep "^${key}="`"
        fi
    done
  fi
}

#unalias ss
function ssh() {
  if [ -n "$TMUX" ] # set only if within running tmux
  then
    # fix ssh agent envs
    fixssh

    window_index=$(tmux display-message -p '#I')

    # arbitrary environment variable name to remember ssh args like server
    # hostname so we can connect again.
    session_variable_name="window_${window_index}_ssh_args"

    # save in tmux session variable
    tmux setenv $session_variable_name "$*"

    # set window title
    tmux rename-window "ssh:`echo $1 | sed 's/.directi.com$//g'`"

    # run ssh
    /usr/bin/ssh -o ServerAliveInterval=60 $*

    # unset variable so new panes don't continue ssh-ing to this server
    tmux setenv -u $session_variable_name
  else
    /usr/bin/ssh -o ServerAliveInterval=60 $*
  fi

  # rename title back
  tmux rename-window zsh
}

function git() {
    fixssh
    /usr/bin/git $*
}

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
alias sudo=''
unset SSH_ASKPASS
tmv() { tmux movew -s $1 -t $2 }

# custom installed binaries
PATH=$PATH:$HOME/bin

dk() { host=$1; shift; docker -H $host:4444 $@; }