--- IMPORTS --------------------------------------

-- Base
import XMonad
import Control.Monad
import qualified XMonad.StackSet as W

-- System
import System.Exit

-- Data types
import Data.Monoid
import Data.Function
import Data.List
import Data.Maybe
import qualified Data.Map as M

-- Hooks
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog

-- Actions
import XMonad.Actions.MouseResize
import XMonad.Actions.WithAll

-- Utils
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Util.NamedWindows

-- Layout Modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.MultiToggle
import XMonad.Layout.WindowArranger
import XMonad.Layout.Renamed
import qualified XMonad.Layout.MultiToggle as MT
import qualified XMonad.Layout.ToggleLayouts as T

-- Layouts
import XMonad.Layout.ResizableTile
import XMonad.Layout.SimplestFloat

--- SETTINGS -------------------------------------
sFont           = "xft:Fira Code:regular:size=12:antialias=true:hinting=true"
sModMask        = mod4Mask
sTerminal       = "alacritty"
sBrowser        = "firefox"
sEditor         = "vim"
sBorderWidth    = 3
sBorderNormal   = "#4a4e56"
sBorderFocus	= "#888888"
--sBorderFocus    = "#46d9ff"
sFocusAtMouse   = True
sRegisterClick  = False -- Sends click event to the window when clicked to focus
sWorkspaces     = [ "dev", "www", "mus", "gam", "dsc", "vbx", "ex7", "ex8", "ex9" ]
sWorkspaceIndices = M.fromList $ zipWith (,) sWorkspaces [1..]

--- UTILS ----------------------------------------

sClickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
	where i = fromJust $ M.lookup ws sWorkspaceIndices

sSpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
sSpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

--- KEYBINDS -------------------------------------

kKeys = [
        -- XMonad controls
        ("M-S-r",           spawn "xmonad --recompile; xmonad --restart"),
        ("M-l",             io exitSuccess),
	    ("M-S-s",	        spawn "shutdown now"),
        ("M-q",		        kill),

        -- Open Applications
        ("M-<Return>",      spawn (sTerminal)),
        ("M-S-<Return>",    spawn "rofi -show run"),
        ("M-e",             spawn "emacs"),
	    ("M-v",             spawn "code"),
	    ("M-b",		        spawn "firefox"),

	    -- Floating Windows
	    ("M-f",             sendMessage (T.Toggle "floats")),
	    ("M-t",             withFocused $ windows . W.sink),
	    ("M-S-t",           sinkAll),

        -- Tiling Keybinds
        ("M-n",             sendMessage NextLayout),

        ("M-<Tab>",         windows W.focusDown),
        ("M-S-<Tab>",       windows W.focusUp),
	    ("M-m",		        windows W.focusMaster),       
	    ("M-S-m",           windows W.swapMaster),

        ("M-S-<Left>",      sendMessage Shrink),
        ("M-S-<Right>",     sendMessage Expand),

        ("M-<Space>",       sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts)
    ]

--- LAYOUTS --------------------------------------

tall    = renamed [Replace "Tall"] $
	      sSpacing 8 $ 
          ResizableTall 1 (3/100) (1/2) []

floats  = renamed [Replace "Floats"] $
	      simplestFloat

--- HOOKS ----------------------------------------

hStartup = do
    spawnOnce "volctl &"
    spawnOnce "nm-applet &"

    spawnOnce "setxkbmap is"
    spawnOnce "picom &"
    spawnOnce "nitrogen --restore &"
    spawnOnce "stalonetray &"
    --spawnOnce "trayer --edge top --align right --SetPartialStrut true --expand true --width 8 --transparent true --alpha 0 --tint 0x292d3e --height 50 --distance 650 --distancefrom right"

hLayout = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) l
    where l = tall |||
	          floats

hManage = manageDocks <+> composeAll [
        className =? "MPlayer"          --> doFloat,
        className =? "Gimp"             --> doFloat,
        resource  =? "desktop_window"   --> doIgnore,
        resource  =? "kdesktop"         --> doIgnore   
    ]

--- MAIN -----------------------------------------

main = do
    xmproc <- spawnPipe "xmobar -x 0 $HOME/.config/xmobar/xmobarrc"

    xmonad $ docks $ ewmh def {
        -- Basic Configs
        terminal            = sTerminal,
        focusFollowsMouse   = sFocusAtMouse,
        clickJustFocuses    = sRegisterClick,
        borderWidth         = sBorderWidth,
        modMask             = sModMask,
        workspaces          = sWorkspaces,
        normalBorderColor   = sBorderNormal,
        focusedBorderColor  = sBorderFocus,

        -- Hooks
        layoutHook          = hLayout,
        manageHook          = hManage,
        handleEventHook     = docksEventHook,
        startupHook         = hStartup,
        logHook             = dynamicLogWithPP $ xmobarPP {
		    ppOutput            = hPutStrLn xmproc,
		    ppCurrent           = xmobarColor "#00aaff" "" . wrap "[" "]",
		    ppVisible           = xmobarColor "#ffaa00" "" . wrap " " " ",
		    ppHidden            = xmobarColor "#ffaa00" "" . wrap " " " ",
		    ppHiddenNoWindows   = xmobarColor "#888888" "" . wrap " " " ",
		    ppTitle             = xmobarColor "#b3afc2" "" . shorten 60,
			ppLayout			= xmobarColor "#00aaff" "",
		    ppSep               = "<fc=#666666> | </fc>",
		    ppUrgent            = xmobarColor "#c45500" "" . wrap "!" "!",
		    ppExtras            = [gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset],
		    ppOrder             = \(ws:l:t:ex) -> [ws,l] -- ++ex++[t]
	    }
    } `additionalKeysP` kKeys
