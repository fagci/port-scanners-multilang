#!/usr/bin/env dart

import 'dart:async';
import 'dart:io';

const host = "192.168.0.200";
const timeout = Duration(milliseconds: 750);

Future check(port) async {
  return Socket.connect(host, port, timeout: timeout).then((s) {
    print(s.remotePort);
    s.destroy();
  }).catchError((e) => null);
}

Future main() async {
  var ports = new List<int>.generate(128, (i) => i + 1);
  return Future.wait(ports.map(check));
}
