##
# Auto expand global aliases on pressing space
##

function expand-alias()
{
    if [[ "$LBUFFER" =~ " \S+\$" ]]; then
        zle _expand_alias
        zle expand-word
    fi
    zle magic-space
}

zle -N expand-alias
