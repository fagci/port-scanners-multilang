#!/usr/bin/env python3

import asyncio
 
async def check(host, port, timeout=0.75):
    conn_task = asyncio.open_connection(host, port)
    try:
        (await asyncio.wait_for(conn_task, timeout))[1].close()
        return port
    except:
        pass
 
async def main(host, ports):
    tasks = [check(host, port) for port in ports]
    results = await asyncio.gather(*tasks)
    for port in filter(bool, results):
        print(port)
 
asyncio.run(main('192.168.0.200', range(1, 128)))
