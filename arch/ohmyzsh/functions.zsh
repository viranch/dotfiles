# pretty print IPs
ipp() {
    netstat -i | tail -n+3 | awk '{print $1}' | grep -v "^lo$" | while read dev; do
        ip=`ifconfig $dev | grep "inet[^6]" | awk '{print $2}'`
        test -n "$ip" && echo "$dev: $ip"
    done
}

function share() {
    temp="/tmp/myshare-$RANDOM"
    mkdir -p $temp
    for f in "$@"; do
        ln -s "$(realpath $f)" "$temp/$(basename $f)"
    done

    echo -n "Starting server at"
    ipp | while read ip; do
        echo -n " http://`echo $ip|cut -d' ' -f2`:8000/"
    done
    echo

    cd $temp
    python2 -m SimpleHTTPServer 2> /dev/null

    cd -
    rm -rf $temp
}

function fixssh() {
  if [ -n "$TMUX" ] # set only if within running tmux
  then
    for key in SSH_AUTH_SOCK SSH_CONNECTION SSH_CLIENT; do
        if (tmux show-environment | grep "^${key}" > /dev/null); then
            #value=`tmux show-environment | grep "^${key}" | sed -e "s/^[A-Z_]*=//"`
            #export ${key}="${value}"
            export "`tmux show-environment | grep "^${key}="`"
        fi
    done
  fi
}
