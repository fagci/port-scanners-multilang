local socket = require("socket")

workers = {}

for _=1,128 do
    table.insert(workers, coroutine.create(function(port)
        s = socket.tcp()
        s:settimeout(0.55)

        if s:connect("192.168.0.200", port) then
            coroutine.yield(port)
        end
        s:close()
    end))
end

for i,w in ipairs(workers) do
    _, port = coroutine.resume(w, i)
    if port then
        print(port)
    end
end
