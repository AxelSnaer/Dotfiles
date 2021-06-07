local keybindfunctions = require("keybindfunctions")
local awful = require("awful")
local gears = require("gears")
local logger = require("util/logger")

require("util/strutils")

local parser = {}

function parser.evaluate_value(str, variables)
    local startIdx = 1
    local n = str:sub(1, 1) == "-"
    if (n) then
        startIdx = 2
    end

    local var = str:sub(startIdx, startIdx) == "$"
    local value = nil

    if (var) then
        value = tostring(variables[str:sub(startIdx + 1)])
    else
        value = str:sub(startIdx)
    end

    if (n) then
        value = "-" .. value
    end

    local num = tonumber(value)
    if (num == nil) then
        return value
    else
        return num
    end
end

function parser.parse_arg(str, variables)
    local arg = str:trim()
    local val = keybindfunctions.args[arg]

	if (val ~= nil) then
		return val
	else
		return function() return parser.evaluate_value(arg, variables) end
    end
end

function parser.get_modifiers(keys, modkey)
	local modifiers = {}
	for k, v in pairs(keys) do
		local lv = v:lower():trim()
		if (lv == "mod") then
			table.insert(modifiers, modkey)
		elseif (lv == "shift") then
			table.insert(modifiers, "Shift")
		elseif (lv == "control") then
			table.insert(modifiers, "Control")
		elseif (lv == "mod1") then
			table.insert(modifiers, "Mod1")
		elseif (lv == "mod2") then
			table.insert(modifiers, "Mod2")
		elseif (lv == "mod3") then
			table.insert(modifiers, "Mod3")
		elseif (lv == "mod4") then
			table.insert(modifiers, "Mod4")
		end
	end
	return modifiers
end

function parser.get_function(cmd, variables)
	local func_name = (cmd:split()[1]):trim()
	local arg = cmd:gsub(func_name .. " ", ""):trim()

	local gen_func = keybindfunctions.functions[func_name]

	if (gen_func == nil) then
		logger.log("Function '" .. func_name .. "' does not exist")
		return function() logger.log_error("Keybind assignment failed because function '" .. func_name .. "' does not exist") end, false
	end
	
	local arg_val = parser.parse_arg(arg, variables)
	return gen_func(arg_val)
end

function parser.parse_keybind(keybind, func, modkey, variables)
	local keys = keybind:split("+")
	local key = keys[#keys]:trim()
    local modifiers = parser.get_modifiers(keys, modkey)

    if (tonumber(key) ~= nil) then
        key = "#" .. tostring(tonumber(key) + 9)
    end

	local keyfunc, is_client = parser.get_function(func, variables)
    return modifiers, key, keyfunc, is_client, func:gsub("_", " ")
end

function parser.parse_keybinds(keybinds, modkey, variables)
	local global_keys = {}
	local client_keys = {}

	for k, v in pairs(keybinds) do
		-- Get the group and keybind
		local group_keybind = k:split("/")
		local group = ""
		local keybind_str = group_keybind[1]:trim()
		if (#group_keybind > 1) then
			group = group_keybind[1]:trim()
			keybind_str = group_keybind[2]:trim()
		end

		local modifiers, key, func, is_client, desc = parser.parse_keybind(keybind_str, v, modkey, variables)
		local keybind = awful.key(modifiers, key, func, {description=desc, group=group})

		if (is_client) then
			client_keys = gears.table.join(client_keys, keybind)
		else
			global_keys = gears.table.join(global_keys, keybind)
		end
	end

	return global_keys, client_keys
end

return parser
