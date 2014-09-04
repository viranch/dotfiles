# Generate gitlab web link for commitdiff
function gllink() {
    local chash=$1
    test -z "$chash" && chash=`git log --pretty=format:"%h" | head -n1`
    local link="$(git remote -v | head -n1 | awk '{print $2}' | sed 's/:/\//g' | sed 's/.*@/https:\/\//g' | sed 's/\.git$//g')/commit/$chash"
    test -x /usr/bin/xsel && echo $link | xsel
    test -x /usr/bin/xclip && echo $link | xclip
    echo $link
}

# Generate gitlab web link to create new issue
# and open it with xdg-open
function new_issue() {
    local link="$(git remote -v | head -n1 | awk '{print $2}' | sed 's/:/\//g' | sed 's/git@/https:\/\//g' | sed 's/\.git$//g')/issues/new"
    test -x /usr/bin/xdg-open && xdg-open $link || echo $link
}
alias ni=new_issue

# Generate gitlab web link to create new merge request for current branch
# and open the link with xdg-open
function merge_request() {
    local base="$(git remote -v | head -n1 | awk '{print $2}' | sed 's/:/\//g' | sed 's/git@/https:\/\//g' | sed 's/\.git$//g')"
    local link="$base/merge_requests/new?utf8=%E2%9C%93&merge_request%5Bsource_branch%5D=`current_branch`&merge_request%5Btarget_branch%5D=master"
    test -x /usr/bin/xdg-open && xdg-open $link || echo $link
}
alias mr=merge_request
