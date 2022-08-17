#!/usr/bin/env bash

seq 1 128 \
    | xargs -I@ -P128 timeout 0.75 bash -c \
    '(echo >/dev/tcp/192.168.0.200/@) >& /dev/null && echo "@"'
