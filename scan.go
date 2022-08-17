///usr/bin/true 2>/dev/null; exec /usr/bin/env go run "$0" "$@"

package main

import (
	"fmt"
	"net"
	"strconv"
	"sync"
	"time"
)

func check(ip string, port string, wg *sync.WaitGroup) {
	defer wg.Done()
	c, e := net.DialTimeout("tcp", ip+":"+port, 750*time.Millisecond)
	if e == nil {
		c.Close()
		fmt.Println(port)
	}
}

func main() {
	ip := "192.168.0.200"

	var wg sync.WaitGroup

	port_from := 1
	port_till := 128
	wg.Add(port_till - port_from)

	for i := port_from; i < port_till; i++ {
		go check(ip, strconv.Itoa(i), &wg)
	}

	wg.Wait()
}
