# If not running interactively, do not do anything
[[ $- != *i* ]] && return
[[ $TERM != screen* ]] && test -z "$TMUX" && (tmux attach || tmux new-session) && exit
#[[ $TERM != screen* ]] && test -z "$TMUX" && (tmux new-session) && exit

for i (~/.dotfiles/ohmyzsh-common/*.zsh) source $i
source ~/.dotfiles/centos.zshrc
test -e ~/.dotfiles/work.zshrc && source ~/.dotfiles/work.zshrc

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
  if [ -n "$TMUX_PANE" ] # set only if within running tmux
  then
    # fix ssh agent envs
    fixssh

    # put an event on the ssh agent
    echo | nc `echo $SSH_CONNECTION | cut -d'=' -f2 | cut -d' ' -f1` 11000

    window_index=$(tmux display-message -p '#I')

    # arbitrary environment variable name to remember ssh args like server
    # hostname so we can connect again.
    session_variable_name="window_${window_index}_ssh_args"

    # save in tmux session variable
    tmux setenv -t "$TMUX_PANE" $session_variable_name "$*"

    # set window title
    tmux rename-window -t "$TMUX_PANE" "ssh:`echo $1 | sed 's/\.linkedin\.com$//g'`"

    # run ssh
    /usr/bin/ssh -o ServerAliveInterval=60 $*

    # unset variable so new panes don't continue ssh-ing to this server
    tmux setenv -t "$TMUX_PANE" -u $session_variable_name
  else
    /usr/bin/ssh -o ServerAliveInterval=60 $*
  fi

  # rename title back
  precmd
}

function git() {
    fixssh
    /usr/bin/git $*
}

unset SSH_ASKPASS
tmv() { tmux movew -s $1 -t $2 }

# custom installed binaries
test -d /export/apps/python/2.7.11/bin && export PATH=/export/apps/python/2.7.11/bin:$PATH
test -d /usr/local/go/bin && export PATH=$PATH:/usr/local/go/bin
test -d $HOME/bin && export PATH=$PATH:$HOME/bin
