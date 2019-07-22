#!/usr/bin/awk -f

{
    if (!max_request[$1] || max_request[$1] < $3) {
        max_request[$1] = $3; max_ip[$1] = $2
    }
}

END {
    for (server in max_request) {
        print server, max_ip[server], max_request[server]
    }
}
