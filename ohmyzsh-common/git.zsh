# get the name of the branch we are on
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

parse_git_dirty () {
  if [[ -n $(git status -s 2> /dev/null) ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

# get the status of the working tree
git_prompt_status() {
  INDEX=$(git status --porcelain 2> /dev/null)
  STATUS=""
  if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNTRACKED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^A  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  elif $(echo "$INDEX" | grep '^M  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^ T ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^R  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_RENAMED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNMERGED$STATUS"
  fi
  echo $STATUS
}

# Git aliases
function git_work() {
  git config user.email "viranch.m@directi.com"
}
alias gw='git_work'

function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

alias g='git'
compdef _git g=git

alias gi='git init'
compdef _git gi=git-init

alias ga='git add'
compdef _git ga=git-add

alias gcl='git clone'
compdef _git gcl=git-clone

alias gco='git checkout'
compdef _git gco=git-checkout

alias gb='git checkout -b'
compdef _git gb=git-checkout

alias gst='git status'
compdef _git gst=git-status

alias gl='git pull'
compdef _git gl=git-pull

alias gd='git diff --color=auto'
compdef _git gd=git-diff

alias gdc='gd --cached'
compdef _git _gdc=git-diff

alias gds='gd --stat'
compdef _git gds=git-diff

alias gdn='gd --numstat'
compdef _git gdn=git-diff

# Commit all unstaged files
alias gc='git commit -am'
compdef _git gc=git-commit

# Commit -> Push
gcp() { git commit -am "$1" && git push }

# Pull -> Commit -> Push
glcp() { git pull && git commit -am "$1" && git push }

# Commit only specifically staged files
alias gcm='git commit -m'
compdef _git gcm=git-commit

# Commit staged -> Push
gcmp() { git commit -m "$1" && git push }

# Pull -> Commit staged -> Push
glcmp() { git pull && git commit -m "$1" && git push }

# Commit all unstaged files but write
# commit message in vim
alias gca='git commit -a'
compdef _git gca=git-commit

alias gp='git push'
compdef _git gp=git-push

alias gll='git log --pretty=format:"%C(yellow)%h %C(green)%cd %C(reset)%s %C(red)[%cn]" --color=auto'
compdef _git gll=git-log

alias glg='gll --numstat --date=relative'
compdef _git glg=git-log

alias glgp='glg -p'
compdef _git glgp=git-log

alias gllp='gll -p'
compdef _git gllp=git-log

function gwc() {
    this_commit_hash=`echo $1|cut -c1-7`
    against_commit_hash=`git log --oneline | grep $this_commit_hash -A 1 | tail -n1 | cut -d" " -f1`
    glg -p $against_commit_hash..$this_commit_hash
}

# Show no. of commits by each author
alias ginf='git shortlog -sn'
compdef _git ginf=git-shortlog

alias gss='git status -s'
compdef _git gss=git-status
alias gs='gss' # annoying frequent mistype

alias grh='git reset --hard'
compdef _git grh=git-reset

# Generate link for commitdiff to standard git web interface
function gdlink() {
    local chash=$1
    test -z "$chash" && chash=`git log --pretty=format:"%h" | head -n1`
    local gremote="$(git remote -v | head -n1)"
    local remote=`echo $gremote | grep -o "@.*:" | sed 's/[@:]//g'`
    local repo=`echo $gremote | grep -o ":.*\.git" | sed 's/://g'`
    local link="http://$remote/?p=$repo;a=commitdiff;h=$chash"
    test -x /usr/bin/xsel && echo $link | xsel
    test -x /usr/bin/xclip && echo $link | xclip
    echo $link
}

# Same as 'gdlink', but specific to gitlab web interface
function gllink() {
    local chash=$1
    test -z "$chash" && chash=`git log --pretty=format:"%h" | head -n1`
    local link="$(git remote -v | head -n1 | awk '{print $2}' | sed 's/:/\//g' | sed 's/.*@/https:\/\//g' | sed 's/\.git$//g')/commit/$chash"
    test -x /usr/bin/xsel && echo $link | xsel
    test -x /usr/bin/xclip && echo $link | xclip
    echo $link
}

function mr() {
    local token="ypg3dxF8Ag6vdx8pNNQW"
    local link="$(git remote -v | head -n1 | awk '{print $2}')"
    local project="$(echo $link | cut -d':' -f2 | sed 's/\.git$//g')"
    local base="https://$(echo $link | cut -d':' -f1 | cut -d'@' -f2)"
    local project_id="$(curl -sk -H "PRIVATE-TOKEN: $token" $base/api/v3/projects | ruby -e "require 'json'; puts (JSON.parse(STDIN.read).find{|p| p['path_with_namespace'] == '$project'})['id']")"
    local req="$base/$project/merge_requests/new?utf8=%E2%9C%93&merge_request%5Bsource_project_id%5D=$project_id&merge_request%5Bsource_branch%5D=`current_branch`&merge_request%5Btarget_project_id%5D=$project_id&merge_request%5Btarget_branch%5D=master"
    test -x /usr/bin/xdg-open && xdg-open $req || echo $req
}

alias gconf='git config -e'
compdef _git gconf='git-config'
