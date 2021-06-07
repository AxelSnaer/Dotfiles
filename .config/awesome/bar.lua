local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")

local bar = {}

function bar.create()
    local textclock = wibox.widget.textclock()

    local taglist_buttons = awful.button({ }, 1, function(t) t:view_only() end)

    awful.screen.connect_for_each_screen(function(s)
        s.mylayoutbox = awful.widget.layoutbox(s)
        s.mylayoutbox:buttons(awful.button({ }, 1, function() awful.layout.inc(1) end))

        s.mytaglist = awful.widget.taglist {
            screen = s,
            filter = awful.widget.taglist.filter.all,
            buttons = taglist_buttons
        }

        s.mywibox = awful.wibar({ 
		position = "top",
		screen = s,
		height = 40
	})

        s.mywibox:setup {
            layout = wibox.layout.align.horizontal,
            {
                layout = wibox.layout.fixed.horizontal,
                s.mytaglist,
            },
            {
                layout = wibox.layout.fixed.horizontal,
                textclock
            },
            {
                layout = wibox.layout.fixed.horizontal,
                wibox.widget.systray(),
                s.mylayoutbox
            }
        }
    end)
end

return bar
