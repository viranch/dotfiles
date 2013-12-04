function zsh_stats() {
  history | awk '{print $2}' | sort | uniq -c | sort -rn | head
}

function extract() {
    unset REMOVE_ARCHIVE
    
    if test "$1" = "-r"; then
        REMOVE=1
        shift
    fi
  if [[ -f $1 ]]; then
    case $1 in
      *.tar.bz2) tar xjf $1;;
      *.tar.gz) tar xzf $1;;
      *.tar.xz) tar xJf $1;;
      *.tar.lzma) tar --lzma -xf $1;;
      *.bz2) bunzip $1;;
      *.rar) unrar x $1;;
      *.gz) gunzip $1;;
      *.tar) tar xf $1;;
      *.tbz2) tar xjf $1;;
      *.tgz) tar xzf $1;;
      *.zip) unzip $1;;
      *.Z) uncompress $1;;
      *.7z) 7z x $1;;
      *) echo "'$1' cannot be extracted via >extract<";;
    esac

    if [[ $REMOVE_ARCHIVE -eq 1 ]]; then
        echo removing "$1";
        /bin/rm "$1";
    fi

  else
    echo "'$1' is not a valid file"
  fi
}

ipp() {
    netstat -i | tail -n+3 | awk '{print $1}' | while read dev; do
        echo $dev: `ifconfig $dev | grep "inet[^6]"`
    done
}

function share() {
    temp="/tmp/myshare-$RANDOM"
    mkdir -p $temp
    for f in "$@"; do
        ln -s "$(realpath $f)" "$temp/$(basename $f)"
    done
    cd $temp
    ip=$(ifconfig `netstat -i | tail -n+3 | awk '{print $1}' | head -n1` | grep "inet[^6]" | awk '{ print $2 }')
    echo "Starting server at http://$ip:8000/ ..."
    python2 -m SimpleHTTPServer 2> /dev/null
    cd -
    rm -rf $temp
}
