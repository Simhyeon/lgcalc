require 'src/util'

-- Parse given statement from bot
-- Return data + exit code
function parse_command(statement)
	-- Simply send help message
	if statement == "!gcalc" then
		return execute_binary("./gcalc --help")
	end

	local arg_table = split_string(statement)
	local command = arg_table[1]

	-- Only execugte gcalc command
	-- Possibly preset later
	if command ~= "!gcalc" then
		return nil, 1
	end

	-- Currently this simply sends everything including verbose error
	-- Maybe this behaviour might change later
	return execute_binary("./" .. statement:sub(2,#statement))
end
