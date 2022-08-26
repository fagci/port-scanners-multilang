#!/usr/bin/env python3

from socket import socket, setdefaulttimeout
from threading import Thread

ip = '192.168.0.200'

def check(addr):
    with socket() as s:
        if s.connect_ex(addr) == 0:
            print(addr)

setdefaulttimeout(0.75)

pool = []

for port in range(1, 128):
    t = Thread(target=check, args=[(ip, port)])
    pool.append(t)

[t.start() for t in pool]
[t.join() for t in pool]
