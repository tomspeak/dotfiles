-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- ┃  HAMMERSPOON WINDOW MANAGER            HYPER = hold Tab  ( ⌃ ⌥ ⇧ )
-- ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- ┃
-- ┃  APPS   left-hand cluster · focusing an app also jumps to its Space
-- ┃            q editor   w browser   e chat   r Ghostty   1 mail   2 calendar   3 Music   4 Zoom
-- ┃     work     = VSCode(FB) / Chrome / GChat / Gmail / GCalendar
-- ┃     personal = VSCode / Brave / Signal / Apple Mail / Apple Calendar
-- ┃     (picked by presence of ~/dotfiles/shell/work)
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
        timer = require('hs.timer'),
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

-- track last focused window per screen (used by cross-monitor focus)
local STATE = {
    last_focused_window_by_screen = {},
}

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
    local current_screen = hs.screen.mainScreen()
    local all_screens = hs.screen.allScreens()

    -- Store the current window as the last focused for this screen
    if current_window then
        STATE.last_focused_window_by_screen[current_screen:id()] = current_window
    end

    local other_screens = {}
    for _, screen in ipairs(all_screens) do
        if screen:id() ~= current_screen:id() then
            table.insert(other_screens, screen)
        end
    end

    if #other_screens == 0 then
        return nav_alert('Single screen detected')
    end

    local other_screen = other_screens[1]
    if not other_screen then
        return nav_alert('Could not find other monitor')
    end

    -- Prefer the window we last used on the target screen, if still valid
    local last_focused_on_target = STATE.last_focused_window_by_screen[other_screen:id()]
    local target_window = nil

    if
        last_focused_on_target
        and last_focused_on_target:screen():id() == other_screen:id()
        and not last_focused_on_target:isMinimized()
    then
        target_window = last_focused_on_target
    else
        local windows_on_other_screen = {}
        for _, window in ipairs(hs.window.visibleWindows()) do
            if
                window:screen():id() == other_screen:id()
                and not window:isMinimized()
                and window:application():name() ~= 'Finder'
            then
                table.insert(windows_on_other_screen, window)
            end
        end

        if #windows_on_other_screen == 0 then
            return nav_alert('No windows found on other monitor')
        end

        target_window = windows_on_other_screen[1]
    end

    if not target_window then
        return nav_alert('No window found on other monitor')
    end

    target_window:focus()
    hs.timer.doAfter(0.05, function()
        nav_alert(target_window:application():name())
    end)
end

hs.hotkey.bind(HYPER_KEY, 'n', focus_frontmost_window_on_other_monitor)
hs.hotkey.bind(HYPER_KEY, '\\', function()
    local win = hs.window.focusedWindow()
    if not win then
        return
    end
    local currentScreen = win:screen()
    local nextScreen = currentScreen:next()
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
--   mnemonic. 'g' is reload, '4' is a free spare.
--
--   Work vs personal uses the same marker the shell does:
--   the gitignored ~/dotfiles/shell/work file, present only
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

local is_work = hs.fs.attributes(os.getenv('HOME') .. '/dotfiles/shell/work') ~= nil
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
