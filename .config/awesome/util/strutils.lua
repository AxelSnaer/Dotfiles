local strutils = {}

-- https://stackoverflow.com/questions/1426954/split-string-in-lua
function string:split(sep)
	if (sep == nil) then
		sep = "%s"
	end
	local t = {}
	for str in self:gmatch("([^"..sep.."]+)") do
		table.insert(t, str)
	end
	return t
end

function string:trim()
    return (self:gsub("^%s*(.-)%s*$", "%1"))
end

function string:firstword()
    return self:match("^([%w]+)")
end

function table:combine_to_string(between)
	if (between == nil) then
		between = " "
	end

	local res = ""
	for k, v in pairs(self) do
		res = res .. tostring(v) .. between
	end
	return res:sub(1, #res - #between)
end