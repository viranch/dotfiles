function ipp() {
    netstat -i | tail -n+3 | awk '{print $1}' | grep -v "^lo$" | while read dev; do
        ip=`ifconfig $dev | grep "inet[^6]" | awk '{print $2}' | cut -d':' -f2`
        test -n "$ip" && echo "$dev: $ip"
    done
}

function share() {
    temp="/tmp/myshare-$RANDOM"
    mkdir -p $temp
    for f in "$@"; do
        ln -s "$(readlink -e $f)" "$temp/$(basename $f)"
    done
    cd $temp
    python -m SimpleHTTPServer
    cd -
    rm -rf $temp
}
