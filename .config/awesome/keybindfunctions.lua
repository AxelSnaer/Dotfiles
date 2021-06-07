local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local logger = require("util/logger")

require("util/strutils")
require("awful.hotkeys_popup.keys")

local kbfunctions = {}

kbfunctions.args = {
    left              = function() return "left"  end,
    right             = function() return "right" end,
    up                = function() return "up"    end,
    down              = function() return "down"  end,

    clockwise         = function() return  1 end,
    counter_clockwise = function() return -1 end,
    increase          = function() return  1 end,
    decrease          = function() return -1 end,

    master            = awful.client.getmaster
}

kbfunctions.functions = {
--  Function Name              Outer Function       Inner Function                                            Client 
    show_help                = function(   ) return function() hotkeys_popup.show_help()                    end, false end,
    move_window              = function(dir) return function() awful.client.swap.global_bydirection(dir())  end, false end,
    rotate_focus             = function(dir) return function() awful.client.focus.byidx(dir())              end, false end,
    resize_master            = function(amt) return function() awful.tag.incmwfact(amt())                   end, false end,
    modify_master_count      = function(amt) return function() awful.tag.incnmaster(amt(), nil, true)       end, false end,
    run                      = function(cmd) return function() awful.spawn(cmd())                           end, false end,
    restart_awesome          = function(   ) return function() awesome.restart()                            end, false end,
    quit_awesome             = function(   ) return function() awesome.quit()                               end, false end,

    toggle_fullscreen        = function(   ) return function(c) c.fullscreen=not c.fullscreen;c:raise()     end, true  end,
    toggle_floating          = function(   ) return function( ) awful.client.floating.toggle()              end, true  end,
    set_focus                = function(val) return function( ) client.focus = val()                        end, true  end,
    swap_with                = function(val) return function(c) c:swap(val())                               end, true  end,
    kill_current             = function(   ) return function(c) c:kill()                                    end, true  end,

    set_workspace            = function(num) return function( )
        local screen = awful.screen.focused()

        local dbg = num
        local tag = screen.tags[num()]
        if (tag) then
            tag:view_only()
        end
    end, false end,

    move_to_workspace        = function(num) return function( )
        if (client.focus) then
            local tag = client.focus.screen.tags[num()]
            if (tag) then
                client.focus:move_to_tag(tag)
            end
        end
    end, false end
}

return kbfunctions
