#!/usr/bin/awk -f

{
    requests[$3][$4]++;

    if (!max_request[$3] || max_request[$3] < requests[$3][$4]) {
        max_request[$3] = requests[$3][$4];
        max_ip[$3] = $4;
    }
}

END {
    for (server in max_request) {
        print server, max_ip[server], max_request[server]
    }
}
