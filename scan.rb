#!/usr/bin/env ruby
# frozen_string_literal: true

require 'socket'

IP = '192.168.0.200'.freeze
TIMEOUT = 0.75

(1..128).map do |port|
  Thread.new do
    s = Socket.tcp(IP, port, connect_timeout: TIMEOUT)
    puts port
  rescue Errno::ETIMEDOUT
  else
    s.close
  end
end.each(&:join)
