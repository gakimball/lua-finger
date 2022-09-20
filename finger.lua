#!/usr/bin/env lua

local socket = require('socket')
local server = assert(socket.bind('*', 79))

local ip, port = server:getsockname()

print('Listening: '..ip..':'..port)

local folder = arg[1]

assert(folder, 'Must pass a folder as an argument')

local sendresponse = function(client, filename)
	local file = io.open(folder .. '/' .. filename .. '.txt')

	if file == nil then
		return false
	end

	for line in file:lines() do
		client:send(line..'\n')
	end

	file:close()

	return true
end

while true do
	local client = server:accept()
	client:settimeout(10)
	local input, err = client:receive()

	if err then
		print('Error: '..err)
	else
		print('Request: '..input..' ('..#input..' characters)')

		local handled = false

		if #input == 0 then
			handled = sendresponse(client, '_index')
		else
			handled = sendresponse(client, input)
		end

		if not handled then
			sendresponse(client, '_notfound')
		end
	end

	client:close()
end
