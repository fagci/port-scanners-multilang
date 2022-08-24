#!/usr/bin/env tclsh

set host "192.168.0.200"
set wait_group 0

proc check {host port} {
    global wait_group
    incr wait_group
    set s [socket -async $host $port]
    fileevent $s writable [list OnOk $s $port]
    after 750 [list disconnect $s]
}

proc OnOk {s port} {
    puts $port
    disconnect $s
}

proc disconnect {s} {
    global wait_group
    catch {close $s}
    incr wait_group -1
}

for {set port 1} {$port < 128} {incr port} {
    check $host $port
}

while {[set wait_group] > 1} {
    vwait wait_group
}
