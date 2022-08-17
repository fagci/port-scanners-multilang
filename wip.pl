#!/usr/bin/env perl
$| = 1;

use IO::Select;
use IO::Socket::INET;
use strict;
use warnings;

my $host = '192.168.0.200';

my $s = IO::Select->new();

my @sockets = ();

foreach my $port (1..128) {
    my $client = IO::Socket::INET->new();
    $client->blocking(0);
    $client->connect("${host}:${port}");
    push(@sockets, $client);
}

my @t=();
my (@r, @w, @e) = IO::Select->new(@sockets)->select(@t,@sockets,@t, 0.75);

print(@w);
foreach my $client (@w) {
    print("${client} open\n");
}
