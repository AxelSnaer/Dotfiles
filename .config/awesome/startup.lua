return {
    -- Set keyboard layout
    "setxkbmap is",

    -- Restart picom
    "killall picom",
    "picom --experimental-backend &",

    -- Start nitrogen
    "nitrogen --restore &",

    -- Launch polybar
    --"~/.config/polybar/launch.sh"
}
