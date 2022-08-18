# vim: filetype=ruby
require "socket"

(1...128).map do |port|
  spawn do
    s = TCPSocket.new
    s.connect("192.168.0.200", port, 0.75)
    puts port
    s.close
  rescue IO::TimeoutError
  end
end

Fiber.yield
