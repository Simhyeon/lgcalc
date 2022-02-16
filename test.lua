require 'src/util'
require 'src/gcalc'

local arg = "!gcalc tktk"
local arg = "!gcalc range --count 5 --probability 0.2"

local data, code = parse_command(arg)

if data then
	print("Statuscode : " .. code)
	print(data)
end
