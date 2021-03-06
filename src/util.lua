-- Split command with given separator
function split_string(inputstr, sep)
	if sep == nil or sep == "" then
		sep = "%s"
	end

	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		table.insert(t, str)
	end
	return t
end

-- Read a file into a string
function read_file(path)
	local open = io.open
    local file = open(path, "r")
    if not file then return nil end
    local content = file:read "*a" -- *a or *all reads the whole file
    file:close()
    return content
end

-- Both print stdout and stderr
function execute_binary(argument)
	local file = io.popen(argument .. " 2>&1", "r")
	local data = file:read("*all")
	local rc = {file:close()}
	return data, rc[3]
end
