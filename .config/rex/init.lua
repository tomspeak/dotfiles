-- Add tmux-style sequences without replacing Rex's native shortcuts.
-- App appearance and terminal settings are managed by rex/preferences.sh.
-- After editing: rex config check && rex config reload

rex.bind("ctrl+a>\\", "pane.split", { direction = "right" })
rex.bind("ctrl+a>-", "pane.split", { direction = "down" })
rex.bind("ctrl+a>c", "client.tab.new")
rex.bind("ctrl+a>n", "client.tab.next")
rex.bind("ctrl+a>p", "client.tab.previous")
rex.bind("ctrl+a>,", "client.tab.rename")
rex.bind("ctrl+a>x", "pane.close")
rex.bind("ctrl+a>z", "pane.zoom")
rex.bind("ctrl+a>r", "client.config.reload")
rex.bind("ctrl+a>g", "client.theme.change")
-- Closest equivalent to tmux's session/window tree.
rex.bind("ctrl+a>ctrl+j", "session.switch")

for index = 1, 9 do
	rex.bind("ctrl+a>" .. index, "client.tab.goto", { index = index })
end

-- Match tmux's double-prefix pane cycling; prefix+a sends a literal Ctrl+A.
rex.bind("ctrl+a>ctrl+a", "pane.focus_next")
rex.bind("ctrl+a>a", "pane.send_key", { key = "ctrl+a" })
