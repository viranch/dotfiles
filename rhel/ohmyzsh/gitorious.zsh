# Generate link for commitdiff to standard git web interface
function gslink() {
    local chash=$1
    test -z "$chash" && chash=`git log --pretty=format:"%h" | head -n1`
    local gremote="$(git remote -v | head -n1)"
    local remote=`echo $gremote | sed 's/.*@\(.*\):.*/\1/g'`
    local repo=`echo $gremote | sed 's/.*:\(.*\)\.git.*/\1/g'`
    local link="https://$remote/$repo/commit/$chash"
    test -x /usr/bin/xsel && echo $link | xsel
    test -x /usr/bin/xclip && echo $link | xclip
    echo $link
}
