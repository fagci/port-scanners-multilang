#!/usr/bin/php
<?php

$sockets = [];

for($port = 1; $port < 128; $port++) {
    $sock = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);
    if(!$sock) continue;

    socket_set_nonblock($sock);
    @socket_connect($sock, '192.168.0.200', $port);
    $sockets[$port] = $sock;
}

$_ = null;

socket_select($_, $sockets, $_, 0.75);

foreach ($sockets as $sock) {
    $port = array_search($sock, $sockets);
    if($port) echo "$port\n";
    @socket_close($sock);
}

