#include <iostream>
#include <unistd.h>
#include <thread>
#include <vector>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <arpa/inet.h>

using namespace std;

in_addr_t ip = inet_addr("192.168.0.200");
int synRetries = 1;

void check(int port) {
    struct sockaddr_in addr;
    addr.sin_family = AF_INET; 
    addr.sin_addr.s_addr = ip;
    addr.sin_port = htons(port);
    int s = socket(AF_INET, SOCK_STREAM, 0);
    setsockopt(s, IPPROTO_TCP, TCP_SYNCNT, &synRetries, sizeof(synRetries));

    if(connect(s, (struct sockaddr *)&addr, sizeof(addr)) >= 0) {
        cout << port << endl;
    }

    close(s);
}

int main() {
    vector<thread> threads;
    for(int port = 1; port <= 128; port++) {
        threads.emplace_back(thread(check, port));
    }
    for (auto& thread : threads) thread.join();
}
