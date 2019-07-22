#!/usr/bin/awk -f

{
    requests[$3][$4]++
}

END {
    for (server in requests) {
        for (ip in requests[server]) {
            print server, ip, requests[server][ip]
        }
    }
}
