-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- ┃  HAMMERSPOON WINDOW MANAGER            HYPER = hold Tab  ( ⌃ ⌥ ⇧ )
-- ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- ┃
-- ┃  APPS   left-hand cluster · focusing an app also jumps to its Space
-- ┃            q editor   w browser   e chat   r Ghostty   1 mail   2 calendar   3 Music   4 Zoom
-- ┃     work     = VSCode(FB) / Chrome / GChat / Gmail / GCalendar
-- ┃     personal = VSCode / Brave / Signal / Apple Mail / Apple Calendar
-- ┃     (picked by presence of shell/work in the dotfiles repository)
-- ┃
-- ┃  WINDOW    h / l  half left / right       space  full screen
-- ┃            j / k  left / right corner  (press again to flip top<->bottom)
-- ┃            n  focus other monitor      \  move window to other monitor
-- ┃
-- ┃  SPACES    [ / ]  prev / next space    (via Karabiner -> ctrl arrow)
-- ┃
-- ┃  SYSTEM    g  reload config
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Setup
---@diagnostic disable-next-line: undefined-field
local hs = _G.hs
    or {
        console = require('hs.console'),
        alert = require('hs.alert'),
        hotkey = require('hs.hotkey'),
        window = require('hs.window'),
    }

hs.console.clearConsole()
local HYPER_KEY = { 'ctrl', 'option', 'shift' }

hs.alert.defaultStyle.fadeInDuration = 0
hs.alert.defaultStyle.fadeOutDuration = 0

hs.hotkey.bind(HYPER_KEY, 'g', hs.reload)

-- Setup grid for window management: 24 columns wide, 2 rows tall
hs.grid.setGrid('24x2')
hs.grid.setMargins({ 0, 0 }) -- no margins, full screen coverage

-- disable window animation (moving or resizing)
hs.window.animationDuration = 0

---@type string | nil
local nav_alert_id = nil

---@param msg string
local function nav_alert(msg)
    hs.alert.closeSpecific(nav_alert_id)
    nav_alert_id = hs.alert.show(msg)
end

-- ===================================================
--   Window placement (grid is 24 wide x 2 tall)
-- ===================================================
local function place(cell)
    local win = hs.window.focusedWindow()
    if not win then
        return hs.alert.show('No focused window')
    end
    hs.grid.set(win, cell)
end

-- Quarter corners: j = left side, k = right side. Pressing the same key again
-- flips between the top and bottom corner on that side, so 2 keys reach all 4.
local TOP_LEFT = { x = 0, y = 0, w = 12, h = 1 }
local BOTTOM_LEFT = { x = 0, y = 1, w = 12, h = 1 }
local TOP_RIGHT = { x = 12, y = 0, w = 12, h = 1 }
local BOTTOM_RIGHT = { x = 12, y = 1, w = 12, h = 1 }

local function cell_is(cell, target)
    return cell
        and math.floor(cell.x + 0.5) == target.x
        and math.floor(cell.y + 0.5) == target.y
        and math.floor(cell.w + 0.5) == target.w
        and math.floor(cell.h + 0.5) == target.h
end

-- Snap to the top corner on this side; if already there, drop to the bottom one.
local function corner(top, bottom)
    local win = hs.window.focusedWindow()
    if not win then
        return hs.alert.show('No focused window')
    end
    local current = hs.grid.get(win)
    hs.grid.set(win, cell_is(current, top) and bottom or top)
end

hs.hotkey.bind(HYPER_KEY, 'h', function()
    place({ x = 0, y = 0, w = 12, h = 2 }) -- half left
end)
hs.hotkey.bind(HYPER_KEY, 'l', function()
    place({ x = 12, y = 0, w = 12, h = 2 }) -- half right
end)
hs.hotkey.bind(HYPER_KEY, 'j', function()
    corner(TOP_LEFT, BOTTOM_LEFT) -- left corner (press again to flip top/bottom)
end)
hs.hotkey.bind(HYPER_KEY, 'k', function()
    corner(TOP_RIGHT, BOTTOM_RIGHT) -- right corner (press again to flip top/bottom)
end)
hs.hotkey.bind(HYPER_KEY, 'space', hs.grid.maximizeWindow) -- full screen

-- ===================================================
--   Move / focus across monitors
-- ===================================================
local function focus_frontmost_window_on_other_monitor()
    local current_window = hs.window.focusedWindow()
    local current_screen = (current_window and current_window:screen()) or hs.screen.mainScreen()
    local other_screen
    for _, screen in ipairs(hs.screen.allScreens()) do
        if screen:id() ~= current_screen:id() then
            other_screen = screen
            break
        end
    end
    if not other_screen then
        return nav_alert('Single screen detected')
    end

    -- Front-to-back order already remembers the last visible window used there.
    for _, window in ipairs(hs.window.orderedWindows()) do
        local screen = window:screen()
        local app = window:application()
        if screen and screen:id() == other_screen:id() and app and window:isStandard() then
            local name = app:name()
            window:focus()
            return nav_alert(name or 'Window focused')
        end
    end
    nav_alert('No windows found on other monitor')
end

hs.hotkey.bind(HYPER_KEY, 'n', focus_frontmost_window_on_other_monitor)
hs.hotkey.bind(HYPER_KEY, '\\', function()
    local win = hs.window.focusedWindow()
    if not win then
        return
    end
    local currentScreen = win:screen()
    local nextScreen = currentScreen and currentScreen:next()
    if nextScreen then
        win:moveToScreen(nextScreen)
    end
end)

-- ===================================================
--   App launch / focus
--   Focusing an app also jumps to the Space where it
--   lives (AppleSpacesSwitchOnActivate is enabled in
--   preferences.sh), so each app key doubles as a Space
--   jump. Launched by bundle id — PWA names are unstable
--   ("Google Chat 1") and collide (Calendar vs Apple's).
--
--   Ergonomic left-hand cluster (Tab held by left hand):
--   most-used apps on the easiest keys. Positional, not
--   mnemonic. 'g' is reload, '4' is Zoom.
--
--   Work vs personal uses the same marker the shell does:
--   the gitignored shell/work file in the repository, present only
--   on the work machine. Env vars can't be used here —
--   Hammerspoon is launched by launchd and does not inherit
--   the shell environment.
-- ===================================================
local WORK_APPS = {
    q = 'com.facebook.fbvscode', -- VS Code (FB build)
    w = 'com.google.Chrome', -- Chrome
    e = 'com.google.Chrome.app.pommaclcbfghclhalboakcipcmmndhcj', -- Google Chat
    r = 'com.mitchellh.ghostty', -- Ghostty
    ['1'] = 'com.google.Chrome.app.fmgjjmmmlfnkbppncabfkddbjimcfncm', -- Gmail
    ['2'] = 'com.google.Chrome.app.gihbagcjamhppndmlkgmccomodfodggj', -- Calendar
    ['3'] = 'com.apple.Music', -- Apple Music
}
local PERSONAL_APPS = {
    q = 'com.microsoft.VSCode', -- VS Code
    w = 'com.brave.Browser', -- Brave
    e = 'org.whispersystems.signal-desktop', -- Signal
    r = 'com.mitchellh.ghostty', -- Ghostty
    ['1'] = 'com.apple.mail', -- Apple Mail
    ['2'] = 'com.apple.iCal', -- Apple Calendar
    ['3'] = 'com.apple.Music', -- Apple Music
}

local config_file = hs.fs.pathToAbsolute(hs.configdir .. '/init.lua')
local dotfiles = config_file and config_file:match('^(.*)/%.config/hammerspoon/init%.lua$')
local is_work = dotfiles and hs.fs.attributes(dotfiles .. '/shell/work') ~= nil
local apps = is_work and WORK_APPS or PERSONAL_APPS

for key, bundle_id in pairs(apps) do
    hs.hotkey.bind(HYPER_KEY, key, function()
        hs.application.launchOrFocusByBundleID(bundle_id)
    end)
end

-- Zoom: same bundle id on work + personal, so bound outside the per-machine tables
hs.hotkey.bind(HYPER_KEY, '4', function()
    hs.application.launchOrFocusByBundleID('us.zoom.xos')
end)

-- ===================================================
--   Spaces
-- ===================================================
-- Space switching is handled in Karabiner (Tab + [ / ] -> ctrl+left/right,
-- the native macOS "move a space" shortcut) rather than here: hs.spaces.gotoSpace
-- only opens Mission Control without completing the switch on this macOS setup
-- ("Displays have separate Spaces" enabled). Native shortcut = smooth, no overlay.

-- Display a message when Hammerspoon config is loaded successfully
hs.alert('HS: loaded, reload with HYPER+g', 0.7)
