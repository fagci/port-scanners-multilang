// true 2>/dev/null; exec /usr/bin/env node "$0" "$@"

import { Socket } from 'net'

const HOST = '192.168.0.200';

async function check(host, port) {
    let socket = new Socket().setTimeout(750);

    socket.on('timeout', socket.destroy);
    socket.on('error', socket.destroy);

    socket.connect(port, host, function() {
        this.destroy();
        console.log(port);
    });
};

const tasks = [...Array(128)].map((_, i) => check(HOST, i + 1));

for await (const _ of tasks);
