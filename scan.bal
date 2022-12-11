import ballerina/io;
import ballerina/tcp;

public function check_port(int port) returns error? {
    tcp:Client s = check new("192.168.0.200", port);
    check s->close();
}

public function main() returns error? {
    foreach int i in 1 ..< 128 {
        if(!(check_port(i) is error)) {
            io:println(i);
        }
    }
}
