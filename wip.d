import std.stdio;
import std.socket;
import std.concurrency;
import std.datetime;

static void check_port(ushort port) {
    Socket client;
    try {
        auto a = new InternetAddress("192.168.0.200", port);
        client = new TcpSocket();
        client.connect(a); 
        writefln("%d", port);
    } catch (Exception e) {
        client.close();
    }
}

void main() {
    writeln("wee");
    Tid ownerTid = thisTid;

    ushort port = 0;
    for(; port < 128; port++) {
        spawn(&check_port, port);
    }
    writeln("wait");
    receiveTimeout(dur!"msecs"(750), (Tid tid) {});
}
