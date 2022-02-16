require 'src/util'
require 'src/command'

local binary_name = "gcalc"

-- This is all sample text from discorida github
local discordia = require('discordia')
local client = discordia.Client()

client:on('ready', function()
	print('Logged in as '.. client.user.username)
end)

client:on('messageCreate', function(message)
	local arg_table = split_command(message.content)
	local command = arg_table[1]

	-- Check special command
	-- and execute according to it
	if command:sub(1,1) == '!' then
		local result = command_table[command.sub(1,#command)]
		if not result then
			message.channel:send(result)
			return -- Retrun early
		end
	end

	-- Sanitize calcaultion type
	if calc_type_table[command] == nil then
		message.channel:send("ERR : Unsupported calculation type " .. command)
		return
	end

	-- Currently this simply sends everything including verbose error
	-- Maybe this behaviour might change later
	local data = execute_binary(binary_name .. " " .. arg)
	message.channel:send(data)
end)

local token = os.getenv("BOT_TOKEN")
client:run('Bot ' .. token)
