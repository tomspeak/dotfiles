local git_branch = function()
  -- Use git command directly for better performance
  local handle = io.popen 'git branch --show-current 2>/dev/null'
  if handle then
    local branch = handle:read '*a'
    handle:close()
    return branch and branch:gsub('\n', '') or ''
  end
  return ''
end

local function safe_git_branch()
  local ok, result = pcall(git_branch)
  return ok and result or ""
end

_G.git_branch = safe_git_branch

_G.Statusline_filename = function()
  local fname = vim.fn.expand '%:t'
  return fname ~= '' and fname or '[No Name]'
end

_G.Statusline_diagnostics = function()
  local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  return string.format('E:%d W:%d', errors, warnings)
end

-- Set statusline normally
vim.opt.statusline = table.concat {
  ' %{v:lua.Statusline_filename()} %m %r',
  ' %=',
  ' %{v:lua.Statusline_diagnostics()}',
  ' (%{v:lua.git_branch()}) ',
}

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = '*',
  callback = function()
    vim.schedule(function()
      if vim.bo.filetype == 'ministarter' or vim.fn.bufname('%'):match 'starter' then
        vim.o.laststatus = 0
      else
        vim.o.laststatus = 2
      end
    end)
  end,
})
