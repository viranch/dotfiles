# TODO: Explain what some of this does..

bindkey -e
bindkey '\ew' kill-region
bindkey -s '\el' "l\n"
bindkey '^r' history-incremental-search-backward
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history

# make search up and down work, so partially type and hit up/down to find relevant stuff
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
## make Ctrl+p/n work for up/down history search as above
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search

bindkey "^[[H" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[4~" end-of-line

# Space hacks
bindkey '^ ' expand-alias    # do global alias expansion on space
#bindkey '^ ' magic-space    # control-space to bypass expansion
#bindkey -M isearch ' ' magic-space  # also do history expansion on space
bindkey ' ' magic-space      # also do history expansion on space

bindkey '^[[Z' reverse-menu-complete

# clear stuff on left of cursor
bindkey "^U" backward-kill-line

# Key fixes (Del/Ctrl+left/Ctrl+right)
bindkey "^[[3~" delete-char
bindkey "5D" backward-word
bindkey "5C" forward-word
bindkey "3D" backward-word # iTerm + tmux fix
bindkey "3C" forward-word # iTerm + tmux fix
bindkey "[D" backward-word # iTerm fix
bindkey "[C" forward-word # iTerm fix

# Fix Ctrl+Del
bindkey -M emacs '^[[3;5~' kill-word

# consider emacs keybindings:

#bindkey -e  ## emacs key bindings
#
#bindkey '^[[A' up-line-or-search
#bindkey '^[[B' down-line-or-search
#bindkey '^[^[[C' emacs-forward-word
#bindkey '^[^[[D' emacs-backward-word
#
#bindkey -s '^X^Z' '%-^M'
#bindkey '^[e' expand-cmd-path
#bindkey '^[^I' reverse-menu-complete
#bindkey '^X^N' accept-and-infer-next-history
#bindkey '^W' kill-region
#bindkey '^I' complete-word
## Fix weird sequence that rxvt produces
#bindkey -s '^[[Z' '\t'
#
