#!/usr/bin/env -S awk -f

function check(host, port) {
    Service = "/inet/tcp/0/" host "/" port

    PROCINFO[Service, "READ_TIMEOUT"] = 750

    if(getline < Service != -1 || ERRNO ~ /timed/) {
        print port, "open"
    }

    close(Service)
}

BEGIN {
    host="192.168.0.200"
    for(port = 1; port < 128; ++port) check(host, port)
}
