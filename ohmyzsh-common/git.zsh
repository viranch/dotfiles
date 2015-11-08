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
  git config user.email "viranch@linkedin.com"
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

alias gp='git push'
compdef _git gp=git-push
alias g\[=gp # common mistake to type '[' in place of 'p'

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

alias gconf='git config -e'
compdef _git gconf=git-config

alias gcd='cd "$(git rev-parse --show-toplevel)"'

function git_reset_head() {
    git reset HEAD$1
}
alias grs=git_reset_head
compdef _git grs=git-reset
