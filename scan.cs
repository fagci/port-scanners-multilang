using System;
using System.Net.Sockets;
using System.Net;
using System.Threading;

public class Program {
  static IPAddress addr = IPAddress.Parse("192.168.0.200");

  public static void Main(string[] args) {
    for (int i = 0; i < 128; i++)
      Scan(i);
  }

  static void Scan(int port) {
    using (var tcp = new TcpClient()) {
      var ar = tcp.BeginConnect(addr, port, null, null);
      using (var wh = ar.AsyncWaitHandle) {
        if (wh.WaitOne(550, false)) {
          try {
            tcp.EndConnect(ar);
            Console.WriteLine(port);
          } catch {
          }
        }
      }
    }
  }
}
