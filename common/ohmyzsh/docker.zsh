# aliases
alias db='docker build -t'
alias dim='docker images'
alias dimclean='docker rmi `docker images | grep "<none>" | awk "{print \$3}"`'
alias drmi='docker rmi'
alias drn='docker run --rm -it'
alias dpsa='docker ps -a --format "table {{.Names}}\t{{.Command}}\t{{.Status}}\t{{.Ports}}"'
alias drm='docker rm'

# compose
alias dc='docker compose -f $HOME/docker-compose-files/$HOST/docker-compose.yml'
alias dup='dc up -d'
alias ddown='dc down'
alias dps='dc ps -a'
alias dlg='dc logs -f'
alias de='dc exec'
