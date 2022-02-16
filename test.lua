require 'src/util'
require 'src/command'

local arg = "range --count 5 --probability 0.2"
local arg_table = split_command(arg)
local command = arg_table[1]

-- Check special command
-- and execute according to it
if command:sub(1,1) == '!' then
	local result = command_table[command.sub(1,#command)]
	if not result then
		print(result)
	end
end

-- Sanitize calcaultion type
local calc_type = arg_table[2]
if calc_type_table[calc_type] == nil then
	print("Unsupported calculation type " .. calc_type)
end

local file = io.popen("gcalc " .. arg,"r")
local data = file:read("*all")
file:close()

print(data)
