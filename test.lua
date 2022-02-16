require 'src/util'
require 'src/command'

local arg = "!gcalc range --count 5 --probability 0.2"
local arg = "!gcalc"

local arg_table = split_command(arg)
local command = arg_table[1]

if command ~= "!gcalc" then
	return
end

-- Currently this simply sends everything including verbose error
-- Maybe this behaviour might change later
local data = execute_binary(arg:sub(2,#arg))
print(data)
