-- Invoked by zen-tmux.sh against a disposable tmux server.
local zen = require 'config.zen'
local function state()
  local result = vim
    .system({ 'tmux', 'display-message', '-p', '-t', vim.env.TMUX_PANE, '#{status}|#{pane-border-status}|#{window_zoomed_flag}' }, { text = true })
    :wait()
  assert(result.code == 0, result.stderr)
  return vim.trim(result.stdout)
end

local ok, err = xpcall(function()
  assert(state() == '2|top|0', state())
  zen.on_open()
  assert(state() == 'off|off|1', state())
  zen.on_close()
  assert(state() == '2|top|0', state())
  assert(vim.system({ 'tmux', 'resize-pane', '-Z', '-t', vim.env.TMUX_PANE }):wait().code == 0)
  zen.on_open()
  zen.on_close()
  assert(state() == '2|top|1', 'Pre-existing zoom must be preserved')
end, debug.traceback)
if not ok then
  print(err)
  vim.cmd 'cquit 1'
else
  print 'Zen tmux state restoration passed'
  vim.cmd 'qa!'
end
