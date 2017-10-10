function share() {
    temp="/tmp/myshare-$RANDOM"
    mkdir -p $temp
    for f in "$@"; do
        ln -s "$(realpath $f)" "$temp/$(basename $f)"
    done
    cd $temp
    ip=`ifconfig en0 | grep "inet " | awk '{print $2}'`
    echo "Starting server at http://$ip:8000/ ..."
    python -m SimpleHTTPServer 2> /dev/null
    cd -
    rm -rf $temp
}

function listen_clipboard() {
    while true; do nc -l 12000 | pbcopy; pbpaste > /tmp/paste; done
}

unalias ff
ff() { find_file $@ . }
