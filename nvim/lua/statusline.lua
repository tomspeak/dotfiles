_G.Statusline_git_branch = function()
  if vim.fn.exists '*FugitiveHead' == 1 then
    local b = vim.fn.FugitiveHead()
    return b ~= '' and b or ''
  end
  return ''
end

_G.Statusline_filename = function()
  local fname = vim.fn.expand '%:t'
  return fname ~= '' and fname or '[No Name]'
end

_G.Statusline_diagnostics = function()
  local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  return string.format('E:%d W:%d', errors, warnings)
end

-- Set statusline globally, but use per-window-safe syntax
vim.opt.statusline = table.concat {
  ' %{v:lua.Statusline_filename()}',
  ' %=',
  ' %{v:lua.Statusline_diagnostics()}',
  ' (%{v:lua.Statusline_git_branch()}) ',
}
