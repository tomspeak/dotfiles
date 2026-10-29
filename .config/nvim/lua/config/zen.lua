local tmux_state

local function tmux(args)
  local ok, result = pcall(function()
    return vim.system(vim.list_extend({ 'tmux' }, args), { text = true }):wait(1000)
  end)
  if ok and result.code == 0 then
    return vim.trim(result.stdout or '')
  end
  vim.notify('Could not update tmux for Zen mode', vim.log.levels.WARN)
end

local function enter_tmux()
  if not vim.env.TMUX or not vim.env.TMUX_PANE then
    return
  end
  local pane = vim.env.TMUX_PANE
  local info = tmux { 'display-message', '-p', '-t', pane, '#{session_id}|#{window_id}|#{window_zoomed_flag}|#{status}|#{pane-border-status}' }
  if not info then
    return
  end
  local fields = vim.split(info, '|', { plain = true })
  if #fields ~= 5 then
    return
  end
  tmux_state = { pane = pane, session = fields[1], window = fields[2], zoomed = fields[3], status = fields[4], border = fields[5] }
  tmux { 'set-option', '-t', tmux_state.session, 'status', 'off' }
  tmux { 'set-option', '-w', '-t', tmux_state.window, 'pane-border-status', 'off' }
  if tmux_state.zoomed == '0' then
    tmux { 'resize-pane', '-Z', '-t', pane }
  end
end

local function leave_tmux()
  local state = tmux_state
  tmux_state = nil
  if not state then
    return
  end
  tmux { 'set-option', '-t', state.session, 'status', state.status }
  tmux { 'set-option', '-w', '-t', state.window, 'pane-border-status', state.border }
  if state.zoomed == '0' and tmux { 'display-message', '-p', '-t', state.pane, '#{window_zoomed_flag}' } == '1' then
    tmux { 'resize-pane', '-Z', '-t', state.pane }
  end
end

return {
  -- Keep existing Git and dim settings; window-local options provide the quiet UI.
  config = function(opts)
    opts.toggles = {}
  end,
  win = {
    width = 80,
    height = 0.9,
    backdrop = { transparent = true, blend = 0 },
    wo = {
      signcolumn = 'no',
      number = false,
      relativenumber = false,
      cursorline = false,
      cursorcolumn = false,
      foldcolumn = '0',
      list = false,
      wrap = true,
      linebreak = true,
      spell = true,
      conceallevel = 2,
    },
  },
  on_open = function()
    require('core.statusline').set_zen(true)
    enter_tmux()
  end,
  on_close = function()
    leave_tmux()
    require('core.statusline').set_zen(false)
  end,
}
