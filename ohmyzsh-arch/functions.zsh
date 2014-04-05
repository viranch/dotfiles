ipp() {
    netstat -i | tail -n+3 | awk '{print $1}' | while read dev; do
        echo $dev: `ifconfig $dev | grep "inet[^6]"`
    done
}
