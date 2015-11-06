VM=default
DOCKER_MACHINE=/usr/local/bin/docker-machine
VBOXMANAGE=/Applications/VirtualBox.app/Contents/MacOS/VBoxManage

#unset DYLD_LIBRARY_PATH
#unset LD_LIBRARY_PATH

function vm_info() {
    if [ ! -f $DOCKER_MACHINE ] || [ ! -f $VBOXMANAGE ]; then
        echo "Either VirtualBox or Docker Machine are not installed. Please re-run the Toolbox Installer and try again."
        return 2
    fi

    $VBOXMANAGE showvminfo $VM &> /dev/null
}

function start_docker() {
    BLUE='\033[0;34m'
    GREEN='\033[0;32m'
    NC='\033[0m'

    vm_info
    VM_EXISTS=$?
    if [ $VM_EXISTS -eq 2 ]; then
        return 1
    elif [ $VM_EXISTS -eq 1 ]; then
        echo "Creating Machine $VM..."
        $DOCKER_MACHINE rm -f $VM &> /dev/null
        rm -rf ~/.docker/machine/machines/$VM
        $DOCKER_MACHINE create -d virtualbox --virtualbox-memory 2048 --virtualbox-disk-size 204800 $VM
    else
        echo "Machine $VM already exists in VirtualBox."
    fi

    VM_STATUS=$($DOCKER_MACHINE status $VM)
    if [ "$VM_STATUS" != "Running" ]; then
        echo "Starting machine $VM..."
        $DOCKER_MACHINE start $VM
    fi

    echo "Setting environment variables for machine $VM..."
    setup_env

    cat << EOF


                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
           \______ o           __/
             \    \         __/
              \____\_______/


EOF
    echo -e "${BLUE}docker${NC} is configured to use the ${GREEN}$VM${NC} machine with IP ${GREEN}$($DOCKER_MACHINE ip $VM)${NC}"
    echo "For help getting started, check out the docs at https://docs.docker.com"
    echo
}

# setup environment for docker
function setup_env() {
    eval $($DOCKER_MACHINE env $VM --shell=zsh)
}

# test debian wheezy image with updated package list for
# running test commands (eg: searching for packages)
function deb() {
    image=$(docker images | grep "^deb\s\+")
    if [[ -z "$image" ]]; then
        mkdir -p /tmp/deb
        cat << EOF > /tmp/deb/Dockerfile
FROM debian:wheezy
RUN apt-get update
EOF
        docker build -t deb /tmp/deb
        rm -rf /tmp/deb
    fi
    docker run --rm -it deb $@
}

# search for packages using the test debian container
function apt-search {
    deb apt-cache search $@
}

vm_info >/dev/null && [[ "$($DOCKER_MACHINE status $VM)" == "Running" ]] && setup_env
