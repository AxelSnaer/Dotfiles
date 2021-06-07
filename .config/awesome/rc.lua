local logger = require "util.logger"
-- Use luarocks if it's installed
pcall(require, "luarocks.loader")

-- Getting dependencies
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")

require("awful.autofocus")
require("awful.hotkeys_popup.keys")

local error_notifier = require("error_notifier")
local startup = require("startup")
local bar = require("bar")
local settings = require("usersettings")

local keybindparser = require("keybindparser")
local keybinds = require("keybinds")

-- Checking for errors and enabling error notifications
error_notifier.checkStartupErrors()
error_notifier.enableErrorNotifications()

-- Initialize beautiful
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- Create the bar
bar.create(settings.modkey)

awful.layout.layouts = {}
-- Assign the layouts
for k, v in pairs(settings.layouts) do
	table.insert(awful.layout.layouts, awful.layout.suit[v])
end

-- Screen Setup
awful.screen.connect_for_each_screen(function(s)

    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

end)


-- Add gaps to all tags
local tags = awful.screen.focused().tags
for i = 1, 9 do tags[i].gap = settings.spacing end

-- Mouse keys
local clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ settings.modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ settings.modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Get and parse the keys from the keybinds.lua file into usable awful.key type
local globalkeys, clientkeys = keybindparser.parse_keybinds(keybinds, settings.modkey, settings)

-- Assign the global keys
root.keys(globalkeys)

-- Rules for clients
awful.rules.rules = {
    {
        rule = { },
        properties = {
            border_width = settings.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    }
}

client.connect_signal("manage", function(c)
    if (awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position) then
        awful.placement.no_offscreen(c)
    end
end)

client.connect_signal("focus", function(c) c.border_color = settings.border_focusColor end)
client.connect_signal("unfocus", function(c) c.border_color = settings.border_normalColor end)
client.connect_signal("mouse::enter", function(c) c:emit_signal("request::activate", "mouse_enter", { raise = false }) end)

for k, start_script in pairs(startup) do
    awful.spawn.with_shell(start_script)
end
