// true 2>/dev/null; exec /usr/bin/env node "$0" "$@"

const net = require('net');

const HOST = '192.168.0.200';

async function check(host, port) {
    let socket = new net.Socket();

    socket.on('timeout', socket.destroy);
    socket.on('error', socket.destroy);

    socket.setTimeout(750);
    socket.connect(port, host, function() {
        this.destroy();
        console.log(port);
    });
};

const tasks = [...Array(128)].map((_, i) => check(HOST, i + 1));

(async () => {
    for await (const _ of tasks);
})();
