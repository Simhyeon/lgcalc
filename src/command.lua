command_table = {}

-- Adding commands
command_table["ping"] = function ()
	return "pong"
end


calc_type_table = {["range"] = 0, ["cond"] = 1, ["qual"] = 2}
