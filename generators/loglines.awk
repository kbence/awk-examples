#!/usr/bin/env awk -f

function random_int(min, max) {
    return min + int(rand()*(max-min))
}

function random_choice(array) {
    return array[random_int(0, length(array))+1]
}

function random_ip() {
    return random_choice(IP_OCTETS) "." random_choice(IP_OCTETS) "." random_choice(IP_OCTETS) \
            "." random_choice(IP_OCTETS)
}

function random_request() {
    return "\"" random_choice(METHODS) " " random_choice(URIS) " HTTP/1.1\""
}

function random_server() {
    return random_choice(SERVERS)
}

function random_code() {
    return random_choice(RESPONSE_CODES)
}

function random_ua() {
    return "\"" random_choice(USER_AGENTS) "\""
}

function next_time() {
    time_str = strftime("%Y-%m-%d %H:%M:%S") "," sprintf("%03d", current_time % 1000)
    current_time += random_int(1, 1000)
    return time_str
}

BEGIN {
    srand(1234)
    split("/,/index.php,/login,/login?redirect=/,/signup,/pricing,/support", URIS, ",")
    split("107,174,184,23,50,52,54,34", IP_OCTETS, ",")
    split("GET,POST,PUT,HEAD,OPTION,DELETE", METHODS, ",")
    split("frontend1,frontend2,frontend3,devel1,devel2", SERVERS, ",")
    split("200,200,200,201,301,302,401,403,404,500,503", RESPONSE_CODES, ",")
    split("curl/7.22.0 (x86_64-pc-linux-gnu) libcurl/7.22.0 OpenSSL/1.0.1 zlib/1.2.3.4 libidn/1.23 librtmp/2.3" \
          "|Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.71 Safari/537.36" \
          "|Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36" \
          "|Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.62 Safari/537.36" \
          "|Mozilla/5.0 (Windows NT 6.1; WOW64; rv:33.0) Gecko/20100101 Firefox/33.0" \
          "|Mozilla/5.0 (Windows NT 10.0; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0" \
          "|Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:58.0) Gecko/20100101 Firefox/58.0" \
          "|Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Win64; x64; Trident/6.0)" \
          "|Mozilla/5.0 (IE 11.0; Windows NT 6.3; Trident/7.0; .NET4.0E; .NET4.0C; rv:11.0) like Gecko" \
          "|Mozilla/5.0 (IE 11.0; Windows NT 6.3; WOW64; Trident/7.0; Touch; rv:11.0) like Gecko",
          USER_AGENTS, "|")
    current_time = systime() * 1000
}

{
    print next_time(), random_server(), random_ip(), random_request(), random_code(), random_ua(), \
        random_int(5000, 1500000), random_int(80, 54000)
}
