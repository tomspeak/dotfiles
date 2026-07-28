-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- ┃  HAMMERSPOON WINDOW MANAGER            HYPER = hold Tab  ( ⌃ ⌥ ⇧ )
-- ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- ┃
-- ┃  APPS   focusing an app also jumps to the Space it lives on
-- ┃     c Chat    v VS Code    b Chrome    g Ghostty    e Gmail    a Calendar    m Music
-- ┃
-- ┃  FOCUS      j  next window     k  prev window     n  other monitor
-- ┃
-- ┃  LAYOUT     h / l  snap left / right      u / p  paired resize L / R
-- ┃             o / i  width wider / thinner  space  center
-- ┃             f      maximize               q      cycle quarters
-- ┃
-- ┃  SPACES     [ / ]  prev / next space   (via Karabiner -> ctrl arrow)
-- ┃
-- ┃  SYSTEM     \  move window to other monitor         R  reload config
-- ┃
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

hs.hotkey.bind(HYPER_KEY, 'R', hs.reload)

-- Setup grid for window management
hs.grid.setGrid('24x2')
hs.grid.setMargins({ 0, 0 }) -- no margins, full screen coverage

-- disable window animation (moving or resizing)
hs.window.animationDuration = 0

-- ===================================================
--    Focus between windows in the current workspace
-- ===================================================
local function next_idx(table, value)
    for i, v in ipairs(table) do
        if v:id() == value:id() then
            if i == #table then
                return 1
            else
                return i + 1
            end
        end
    end
end

local function prev_idx(table, value)
    for i, v in ipairs(table) do
        if v:id() == value:id() then
            if i == 1 then
                return #table
            else
                return i - 1
            end
        end
    end
end

local STATE = {
    currentSpaceWindows = {},
    last_focused_window_by_screen = {}, -- track last focused window for each screen
}
-- on window close or open update the list of windows

hs.timer.doAfter(0.9, function()
    local wf = hs.window.filter
    local filter = wf.new(wf.defaultCurrentSpace):setOverrideFilter({
        visible = true,
        currentSpace = true,
        fullscreen = false,
    })

    local function update_current_space_windows()
        local local_windows = {}
        for _, v in ipairs(filter:getWindows()) do
            if v:isMinimized() == false and v:isVisible() == true then
                table.insert(local_windows, v)
            end
        end
        STATE.currentSpaceWindows = local_windows
    end

    filter:subscribe({ hs.window.filter.windowsChanged }, update_current_space_windows)

    update_current_space_windows()

    hs.alert.show('HS: layout ready', 0.7)
end)

---@type string | nil
local nav_alert_id = nil

---@param msg string
local function nav_alert(msg)
    hs.alert.closeSpecific(nav_alert_id)
    nav_alert_id = hs.alert.show(msg)
end

local function focusNextWindowInScreen()
    local currentWindow = hs.window.frontmostWindow()
    if not currentWindow then
        local first_win = STATE.currentSpaceWindows[1]

        if first_win then
            nav_alert('First window: ' .. first_win:application():name())
            first_win:focus()
        end
        return
    end

    if #STATE.currentSpaceWindows < 2 then
        return nav_alert('Nothing to focus')
    end

    local next_i = next_idx(STATE.currentSpaceWindows, currentWindow)

    local next_win = STATE.currentSpaceWindows[next_i]

    if next_win then
        nav_alert(next_win:application():name())
        next_win:focus()
    end
end

local function focusPreviousWindowInScreen()
    local currentWindow = hs.window.frontmostWindow()
    if not currentWindow then
        local first_win = STATE.currentSpaceWindows[1]

        if first_win then
            nav_alert('First window: ' .. first_win:application():name())
            first_win:focus()
        end
        return
    end

    if #STATE.currentSpaceWindows < 2 then
        return nav_alert('Nothing to focus')
    end

    local prev_i = prev_idx(STATE.currentSpaceWindows, currentWindow)

    local prev_win = STATE.currentSpaceWindows[prev_i]

    if prev_win then
        nav_alert(prev_win:application():name())
        prev_win:focus()
    end
end

-- Bind keys to move focus
hs.hotkey.bind(HYPER_KEY, 'j', focusNextWindowInScreen)
hs.hotkey.bind(HYPER_KEY, 'k', focusPreviousWindowInScreen)

-- ===================================================
--   resize windows
-- ===================================================

-- Grid-based window resizing (preserves alignment)
local function get_alignment(cell)
    if cell.x == 0 then
        return 'left'
    elseif cell.x + cell.w == 24 then
        return 'right'
    else
        return 'center'
    end
end

local function increase_win_width()
    local win = hs.window.focusedWindow()
    if not win then
        return hs.alert.show('No focused window')
    end
    local cell_before = hs.grid.get(win)
    if not cell_before then
        return
    end
    local align = get_alignment(cell_before)
    -- Resize by 2 grid units for better centering adjustment after resize
    hs.grid.resizeWindowWider(win)
    hs.grid.resizeWindowWider(win)
    -- Re-align after resize
    local cell_after = hs.grid.get(win)
    if cell_after then
        if align == 'left' then
            cell_after.x = 0
        elseif align == 'right' then
            cell_after.x = 24 - cell_after.w
        else -- center
            cell_after.x = math.floor((24 - cell_after.w) / 2)
        end
        hs.grid.set(win, cell_after)
    end
end

local function decrease_win_width()
    local win = hs.window.focusedWindow()
    if not win then
        return hs.alert.show('No focused window')
    end
    local cell_before = hs.grid.get(win)
    if not cell_before then
        return
    end
    local align = get_alignment(cell_before)
    -- Resize by 2 grid units for better centering adjustment after resize
    hs.grid.resizeWindowThinner(win)
    hs.grid.resizeWindowThinner(win)
    -- Re-align after resize
    local cell_after = hs.grid.get(win)
    if cell_after then
        if align == 'left' then
            cell_after.x = 0
        elseif align == 'right' then
            cell_after.x = 24 - cell_after.w
        else -- center
            cell_after.x = math.floor((24 - cell_after.w) / 2)
        end
        hs.grid.set(win, cell_after)
    end
end

-- Grid-based resize presets (full height)
local resize_widths = { 12, 16, 8 } -- half -> two-thirds -> third
local resize_idx = 1
local function cycle_resize(align)
    local win = hs.window.focusedWindow()
    if not win then
        return hs.alert.show('No focused window')
    end
    local current_cell = hs.grid.get(win)
    if current_cell then
        local current_align = get_alignment(current_cell)
        local is_in_sizes = false
        for _, v in ipairs(resize_widths) do
            if current_cell.w == v then
                is_in_sizes = true
                break
            end
        end
        if not (is_in_sizes and current_align == align) then
            resize_idx = 1
        end
    end
    local w = resize_widths[resize_idx]
    resize_idx = resize_idx % #resize_widths + 1
    local cell
    if align == 'left' then
        cell = { x = 0, y = 0, w = w, h = 2 }
    elseif align == 'right' then
        cell = { x = 24 - w, y = 0, w = w, h = 2 }
    else -- center
        cell = { x = (24 - w) / 2, y = 0, w = w, h = 2 }
    end
    hs.grid.set(win, cell)
end
local function center_or_toggle_resize()
    cycle_resize('center')
end

-- Cycle quarters of the screen: top-left, top-right, bottom-right, bottom-left
local quarter_positions = {
    { x = 12, y = 0, w = 12, h = 1 }, -- top-right
    { x = 12, y = 1, w = 12, h = 1 }, -- bottom-right
    { x = 0, y = 1, w = 12, h = 1 }, -- bottom-left
    { x = 0, y = 0, w = 12, h = 1 }, -- top-left
}
local function cycle_quarters()
    local win = hs.window.focusedWindow()
    if not win then
        return hs.alert.show('No focused window')
    end
    local current_cell = hs.grid.get(win)
    local current_idx = nil
    if current_cell then
        for i, pos in ipairs(quarter_positions) do
            if
                current_cell.x == pos.x
                and current_cell.y == pos.y
                and current_cell.w == pos.w
                and current_cell.h == pos.h
            then
                current_idx = i
                break
            end
        end
    end
    local next_quarter_idx = current_idx and (current_idx % #quarter_positions + 1) or 1
    local cell = quarter_positions[next_quarter_idx]
    hs.grid.set(win, cell)
end

-- ===================================================
--   Paired window resizing (current + previous)
-- ===================================================
local paired_resize_idx_left = 1
local paired_resize_idx_right = 1

local function cycle_resize_paired(align)
    local current_win = hs.window.focusedWindow()
    if not current_win then
        return hs.alert.show('No focused window')
    end

    if #STATE.currentSpaceWindows < 2 then
        return cycle_resize(align)
    end

    -- Find previous window
    local prev_i = prev_idx(STATE.currentSpaceWindows, current_win)
    local prev_win = STATE.currentSpaceWindows[prev_i]

    if not prev_win or prev_win:screen():id() ~= current_win:screen():id() then
        return cycle_resize(align)
    end

    -- Determine which index counter to use
    local resize_idx = (align == 'left') and paired_resize_idx_left or paired_resize_idx_right

    -- Check if we're still cycling within the same alignment
    local current_cell = hs.grid.get(current_win)
    if current_cell then
        local current_align = get_alignment(current_cell)
        local is_in_sizes = false
        for _, v in ipairs(resize_widths) do
            if current_cell.w == v then
                is_in_sizes = true
                break
            end
        end
        if not (is_in_sizes and current_align == align) then
            resize_idx = 1
        end
    end

    local w = resize_widths[resize_idx]
    local remaining = 24 - w

    -- Set current window
    local current_cell_new
    if align == 'left' then
        current_cell_new = { x = 0, y = 0, w = w, h = 2 }
    else -- right
        current_cell_new = { x = remaining, y = 0, w = w, h = 2 }
    end
    hs.grid.set(current_win, current_cell_new)

    -- Set previous window to fill remaining space
    local prev_cell_new
    if align == 'left' then
        prev_cell_new = { x = w, y = 0, w = remaining, h = 2 }
    else -- right
        prev_cell_new = { x = 0, y = 0, w = remaining, h = 2 }
    end
    hs.grid.set(prev_win, prev_cell_new)

    -- Increment and wrap index
    resize_idx = resize_idx % #resize_widths + 1
    if align == 'left' then
        paired_resize_idx_left = resize_idx
    else
        paired_resize_idx_right = resize_idx
    end

    -- Refocus current window
    current_win:focus()
    nav_alert(current_win:application():name() .. ' + ' .. prev_win:application():name())
end

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

    -- Find the other screen (not the current one)
    local other_screen = other_screens[1]
    if not other_screen then
        return nav_alert('Could not find other monitor')
    end

    -- Check if we have a previously focused window for the target screen
    local last_focused_on_target = STATE.last_focused_window_by_screen[other_screen:id()]
    local target_window = nil

    -- If we have a previously focused window and it's still valid, use it
    if
        last_focused_on_target
        and last_focused_on_target:screen():id() == other_screen:id()
        and not last_focused_on_target:isMinimized()
    then
        target_window = last_focused_on_target
    else
        -- Fall back to finding any available window on the other screen
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

    -- Focus the target window
    target_window:focus()
    hs.timer.doAfter(0.05, function()
        nav_alert(target_window:application():name())
    end)
end

hs.hotkey.bind(HYPER_KEY, 'o', increase_win_width)
hs.hotkey.bind(HYPER_KEY, 'i', decrease_win_width)
hs.hotkey.bind(HYPER_KEY, 'space', center_or_toggle_resize) -- 'c' freed for Chat
hs.hotkey.bind(HYPER_KEY, 'f', hs.grid.maximizeWindow)
hs.hotkey.bind(HYPER_KEY, 'n', focus_frontmost_window_on_other_monitor)

-- Additional grid-based bindings
hs.hotkey.bind(HYPER_KEY, 'h', function()
    cycle_resize('left')
end)
hs.hotkey.bind(HYPER_KEY, 'l', function()
    cycle_resize('right')
end)
hs.hotkey.bind(HYPER_KEY, 'u', function()
    cycle_resize_paired('left')
end)
hs.hotkey.bind(HYPER_KEY, 'p', function()
    cycle_resize_paired('right')
end)
hs.hotkey.bind(HYPER_KEY, '\\', function() -- 'm' freed for Music
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
hs.hotkey.bind(HYPER_KEY, 'q', cycle_quarters)

-- ===================================================
--   App launch / focus
--   Focusing an app also jumps to the Space where it
--   lives (AppleSpacesSwitchOnActivate is enabled in
--   preferences.sh), so each app key doubles as a Space
--   jump. Launched by bundle id — PWA names are unstable
--   ("Google Chat 1") and collide (Calendar vs Apple's).
-- ===================================================
local apps = {
    c = 'com.google.Chrome.app.pommaclcbfghclhalboakcipcmmndhcj', -- Google Chat
    v = 'com.facebook.fbvscode', -- VS Code
    b = 'com.google.Chrome', -- Chrome (browser)
    g = 'com.mitchellh.ghostty', -- Ghostty
    e = 'com.google.Chrome.app.fmgjjmmmlfnkbppncabfkddbjimcfncm', -- Gmail (email)
    a = 'com.google.Chrome.app.gihbagcjamhppndmlkgmccomodfodggj', -- Calendar (agenda)
    m = 'com.apple.Music', -- Apple Music
}
for key, bundle_id in pairs(apps) do
    hs.hotkey.bind(HYPER_KEY, key, function()
        hs.application.launchOrFocusByBundleID(bundle_id)
    end)
end

-- ===================================================
--   Spaces
-- ===================================================
-- Space switching is handled in Karabiner (Tab + [ / ] -> ctrl+left/right,
-- the native macOS "move a space" shortcut) rather than here: hs.spaces.gotoSpace
-- only opens Mission Control without completing the switch on this macOS setup
-- ("Displays have separate Spaces" enabled). Native shortcut = smooth, no overlay.

-- Optional: Display a message when Hammerspoon config is loaded successfully
hs.alert('HS: loaded, reload with HYPER+R', 0.7)
