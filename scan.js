//true 2>/dev/null; exec /usr/bin/env node "$0" "$@"

const net = require('net');

function check(host, port, cb) {
    let socket = new net.Socket();
    socket.check_result = false;

    socket.on('connect', function() {
        socket.check_result = true;
        socket.destroy();
    });

    socket.on('timeout', close);
    socket.on('error', close);
    socket.on('close', function() {
        cb(socket.check_result, port);
    });

    function close() {
        socket.destroy();
    }

    socket.setTimeout(750);
    socket.connect(port, host);
}

let queue = {}

for (let port = 1; port < 128; port++) {
    queue[port] = true;
}

Object.keys(queue).map(function(port) {
    check('192.168.0.200', port, function(s, p) {
        delete queue[p];
        if (s) console.log(p);
    });
});

let interval = setInterval(function() {
    if (Object.keys(queue).length == 0) {
        clearInterval(interval);
    }
});
