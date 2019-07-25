#!/usr/bin/awk -f

{
    ips[$4]++
}

END {
    for (ip in ips) {
        print ips[ip], ip
    }
}
