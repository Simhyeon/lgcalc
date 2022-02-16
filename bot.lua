require 'src/util'
require 'src/gcalc'

-- This is all sample text from discorida github
local discordia = require('discordia')
local client = discordia.Client()

client:on('ready', function()
	print('Logged in as '.. client.user.username)
end)

client:on('messageCreate', function(message)
	local data = parse_command(message.content)
	-- If not nil
	if data then
		message.channel:send(data)
	end
end)

local token = os.getenv("BOT_TOKEN")
client:run('Bot ' .. token)
