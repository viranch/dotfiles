# Generate gitlab web link for commitdiff
function gllink() {
    local chash=$1
    test -z "$chash" && chash=`git log --pretty=format:"%h" | head -n1`
    local link="$(git remote -v | head -n1 | awk '{print $2}' | sed 's/:/\//g' | sed 's/.*@/https:\/\//g' | sed 's/\.git$//g')/commit/$chash"
    test -x /usr/bin/xsel && echo $link | xsel
    test -x /usr/bin/xclip && echo $link | xclip
    echo $link
}

# Generate gitlab web link to create new merge request for current branch
# and open the link with xdg-open
function mr() {
    local token="ypg3dxF8Ag6vdx8pNNQW"
    local link="$(git remote -v | head -n1 | awk '{print $2}')"
    local project="$(echo $link | cut -d':' -f2 | sed 's/\.git$//g')"
    local base="https://$(echo $link | cut -d':' -f1 | cut -d'@' -f2)"
    local project_id="$(curl -sk -H "PRIVATE-TOKEN: $token" $base/api/v3/projects | ruby -e "require 'json'; puts (JSON.parse(STDIN.read).find{|p| p['path_with_namespace'] == '$project'})['id']")"
    local req="$base/$project/merge_requests/new?utf8=%E2%9C%93&merge_request%5Bsource_project_id%5D=$project_id&merge_request%5Bsource_branch%5D=`current_branch`&merge_request%5Btarget_project_id%5D=$project_id&merge_request%5Btarget_branch%5D=master"
    test -x /usr/bin/xdg-open && xdg-open $req || echo $req
}
