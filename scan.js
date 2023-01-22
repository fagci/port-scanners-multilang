// true 2>/dev/null; exec /usr/bin/env node "$0" "$@"

const net = require('net');

const HOST = '192.168.0.200';

function check(host, port) {
    return new Promise((resolve, reject) => {
        let socket = new net.Socket();

        function onSuccess() {
            this.destroy();
            resolve(port);
        };

        function onError() {
            this.destroy();
            resolve(null);
        };

        socket.on('timeout', onError);
        socket.on('error', onError);

        socket.setTimeout(750);
        socket.connect(port, host, onSuccess);
    });
};

const tasks = Array.from(Array(128), (_, i) => check(HOST, i + 1))

Promise.all(tasks).then(r => {
    r.filter(Boolean).forEach(port => console.log(port))
})
