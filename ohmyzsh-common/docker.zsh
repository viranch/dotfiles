VM=default
DOCKER_MACHINE=$(command -v docker-machine)
VBOXMANAGE=$(command -v VBoxManage)

#unset DYLD_LIBRARY_PATH
#unset LD_LIBRARY_PATH

function vm_info() {
    test -z "$DOCKER_MACHINE" && (echo "Docker Machine is not installed."; return 2)
    test -z "$VBOXMANAGE" && (echo "VirtualBox is not installed."; return 2)

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

# # test debian wheezy image with updated package list for
# # running test commands (eg: searching for packages)
# function deb() {
#     image=$(docker images | grep "^deb\s\+")
#     test -z "$image" && docker build -t deb - << EOF
# FROM debian:wheezy
# RUN apt-get update
# EOF
#     docker run --rm -it deb $@
# }
# 
# # search for packages using the test debian container
# function apt-search {
#     deb apt-cache search $@
# }
# 
# function apt-get {
#     app=$1
#     docker build -t $app - << EOF
# FROM debian:wheezy
# RUN apt-get update && apt-get install -y --no-install-recommends $app && rm -rf /var/lib/apt/lists/*
# ENTRYPOINT ["/usr/bin/$app"]
# EOF
#     echo "docker run --rm -it $app"
# }

#vm_info >/dev/null && [[ "$($DOCKER_MACHINE status $VM)" == "Running" ]] && setup_env
