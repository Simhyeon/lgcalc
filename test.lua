require 'src/util'
require 'src/gcalc'

local SEND_LIMIT = 2000

local arg = "!gcalc range --probability 0.01 --count 21 --cost 16 -f console"

local data, code = parse_command(arg)

local chunk = "```\n"
local separator = "\n```"
local next_chunk = ""

local split = split_string(data,"\n")
local counter = 1
local line = ""
local line_sep = "\n"

while split[counter] do
	line = split[counter]
	next_chunk = chunk .. line

	if split[counter+1] then
		local_sep = "\n"
	else
		local_sep = ""
	end

	-- Aggregate chunk by lines for better visibility
	if next_chunk:len() < SEND_LIMIT - separator:len() then
		chunk = next_chunk .. local_sep -- Update chunk
		-- Split text if text is bigger than SEND_LIMIT
	else
		print(chunk .. separator) -- Send chunk
		chunk = "```\n" .. line .. local_sep
	end
	counter = counter + 1
end

if chunk:len() ~= 0 then
	print(chunk .. separator) -- Send chunk
end
