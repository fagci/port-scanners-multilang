#!/usr/bin/env elixir

ip = '192.168.0.200'
ports = 1..128

check = fn port ->
  with {:ok, s} <- :gen_tcp.connect(ip, port, [], 750) do
    :gen_tcp.close(s)
    port
  end
end

ports
|> Task.async_stream(check, max_concurrency: 128)
|> Stream.map(&elem(&1, 1))
|> Stream.filter(&is_number/1)
|> Stream.each(&IO.puts/1)
|> Stream.run()
