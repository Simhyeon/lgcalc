require 'src/util'
require 'src/gcalc'

-- This is all sample text from discorida github
local discordia = require('discordia')
local client = discordia.Client()

client:on('ready', function()
	print('Logged in as '.. client.user.username)
end)

client:on('messageCreate', function(message)
	local data,status_code = parse_command(message.content)
	-- If not nil
	if data then
		-- Error code
		if status_code ~= 0 then
			data = "ERR : Invalid calculation option\n" .. data
		end

		-- Send result wrapped in code block for proper formatting
		message.channel:send("```" .. data .. "```")
	end
end)

-- Get token from environment
local token = os.getenv("BOT_TOKEN")
-- Main entry
client:run('Bot ' .. token)
