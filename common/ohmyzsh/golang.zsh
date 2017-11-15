if [[ -d /usr/local/go ]]; then
    export PATH=$PATH:/usr/local/go/bin
    export GOPATH=$HOME/code/go_path
fi

if [[ -d /usr/local/opt/go ]]; then
    export PATH=$PATH:/usr/local/opt/go/bin
    export GOPATH=$HOME/code/go_path
fi
