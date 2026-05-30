export DOCKER_COMPOSE_DIR="$HOME/code/docker-compose-files/tiny"

# compose wrapper
dc() {
    sub=$1; shift
    dcfile="$DOCKER_COMPOSE_DIR"/$sub/docker-compose.yml
    if [[ $1 == "edit" ]]; then
        $EDITOR "$dcfile"
    else
        docker-compose -f "$dcfile" $@
    fi
}

dcf() {
    sub=$1; shift
    if [[ $1 == "upd" ]]; then
        shift
        dc $sub stop $@
        dc $sub rm -f $@
        dc $sub up -d $@
    else
        dc $sub $@
    fi
}

_dcf() {
    _files -W "$DOCKER_COMPOSE_DIR"
}

compdef _dcf dcf
