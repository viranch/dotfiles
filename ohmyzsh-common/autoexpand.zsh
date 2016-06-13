##
# Auto expand global aliases on pressing space
##

function expand-alias()
{
    zle _expand_alias
    zle expand-word
    zle magic-space
}

zle -N expand-alias
