require 'src/util'
require 'src/gcalc'

local SEND_LIMIT = 2000

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

		local split = split_string(data,"\n")

		-- Loop local variables to avoid assignment 
		-- START
		local chunk = "```\n"
		local separator = "\n```"
		local next_chunk = ""
		local counter = 1
		local target_line = ""
		local line_sep = "\n"
		-- END

		while split[counter] do
			target_line = split[counter]
			next_chunk = chunk .. target_line

			if split[counter+1] then
				line_sep = "\n"
			else
				line_sep = ""
			end

			-- Aggregate chunk by lines for better visibility
			if next_chunk:len() < SEND_LIMIT - separator:len() then
				chunk = next_chunk .. line_sep -- Update chunk
			else -- Split text if text is bigger than SEND_LIMIT
				message.channel:send(chunk .. separator) -- Send chunk
				chunk = "```\n" .. target_line .. line_sep
			end
			counter = counter + 1
		end

		-- Flush remaining chunk
		if chunk:len() ~= 0 then
			message.channel:send(chunk .. separator) -- Send chunk
		end
	end
end)

-- Get token from environment
local token = os.getenv("BOT_TOKEN")
-- Main entry
client:run('Bot ' .. token)
