require 'src/util'
require 'src/command'

-- This is all sample text from discorida github
local discordia = require('discordia')
local client = discordia.Client()

client:on('ready', function()
	print('Logged in as '.. client.user.username)
end)

client:on('messageCreate', function(message)
	local arg_table = split_command(message.content)
	local command = arg_table[1]

	-- Only execugte gcalc command
	-- Possibly preset later
	if command ~= "!gcalc" then
		return
	end

	-- Currently this simply sends everything including verbose error
	-- Maybe this behaviour might change later
	local data = execute_binary("./" .. arg:sub(2,#message.content))
	message.channel:send(data)
end)

local token = os.getenv("BOT_TOKEN")
client:run('Bot ' .. token)
