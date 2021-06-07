local k = {
	["awesome / MOD + s"			] = "show_help",
	["awesome / MOD + Shift + r"	] = "restart_awesome",
	["awesome / MOD + Shift + q"	] = "quit_awesome",
	
	["layout  / MOD + Shift + Left"	] = "move_window left",
	["layout  / MOD + Shift + Right"] = "move_window right",
	["layout  / MOD + Shift + Up"	] = "move_window up",
	["layout  / MOD + Shift + Down"	] = "move_window down",
	["layout  / MOD + Shift + m"	] = "swap_with master",

	["layout  / MOD + Left" 		] = "resize_master -$masterResizeAmount",
	["layout  / MOD + Right"		] = "resize_master $masterResizeAmount",
	["layout  / MOD + Up"   		] = "modify_master_count increase",
	["layout  / MOD + Down" 		] = "modify_master_count decrease",

	["focus   / MOD + Tab"        	] = "rotate_focus clockwise",
	["focus   / MOD + Shift + Tab"	] = "rotate_focus counter_clockwise",
	["focus   / MOD + m"			] = "set_focus master",

	["run	  / MOD + p"	 		] = "run rofi -show run",
	["run	  / MOD + v"	 		] = "run code",
	["run	  / MOD + Return"		] = "run $terminal",
	["run	  / MOD + b"	 		] = "run firefox",
    ["run     / MOD + d"            ] = "run emacs",

	["window  / MOD + f"			] = "toggle_fullscreen",
	["window  / MOD + Shift + space"] = "toggle_floating",
	["window  / MOD + q"			] = "kill_current",

	["workspaces / MOD + 1"			] = "set_workspace 1",
	["workspaces / MOD + 2"			] = "set_workspace 2",
	["workspaces / MOD + 3"			] = "set_workspace 3",
	["workspaces / MOD + 4"			] = "set_workspace 4",
	["workspaces / MOD + 5"			] = "set_workspace 5",
	["workspaces / MOD + 6"			] = "set_workspace 6",
	["workspaces / MOD + 7"			] = "set_workspace 7",
	["workspaces / MOD + 8"			] = "set_workspace 8",
	["workspaces / MOD + 9"			] = "set_workspace 9",

	["workspaces / MOD + Shift + 1"	] = "move_to_workspace 1",
	["workspaces / MOD + Shift + 2"	] = "move_to_workspace 2",
	["workspaces / MOD + Shift + 3"	] = "move_to_workspace 3",
	["workspaces / MOD + Shift + 4"	] = "move_to_workspace 4",
	["workspaces / MOD + Shift + 5"	] = "move_to_workspace 5",
	["workspaces / MOD + Shift + 6"	] = "move_to_workspace 6",
	["workspaces / MOD + Shift + 7"	] = "move_to_workspace 7",
	["workspaces / MOD + Shift + 8"	] = "move_to_workspace 8",
	["workspaces / MOD + Shift + 9"	] = "move_to_workspace 9",
}

return k
