function ipp() {
    netstat -i | tail -n+3 | awk '{print $1}' | grep -v "^lo$" | while read dev; do
        ip=`ifconfig $dev | grep "inet[^6]" | awk '{print $2}' | cut -d':' -f2`
        test -n "$ip" && echo "$dev: $ip"
    done
}
