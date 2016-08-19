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

function do_yubikey() {
    osascript -e 'tell application "yubiswitch" to KeyOn'
    [[ ! -f /tmp/yubi ]] && (echo 0 > /tmp/yubi)
    n=`cat /tmp/yubi`
    echo $n+1 | bc > /tmp/yubi
    sleep 15
    n=`cat /tmp/yubi`
    [[ $n == "1" ]] && osascript -e 'tell application "yubiswitch" to KeyOff'
    echo $n-1 | bc > /tmp/yubi
}

function listen_yubikey() {
    while true; do nc -l 11000; (do_yubikey &); done
}

unalias ff
ff() { find_file $@ . }
