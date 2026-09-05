-- Statusline with modular components

_G.git_branch = function()
  local branch = vim.b.gitsigns_head or ''
  return branch ~= '' and (' (' .. branch .. ') ') or ''
end

-- Word count for prose files
_G.Statusline_wordcount = function()
  local ft = vim.bo.filetype
  if ft == 'markdown' or ft == 'text' or ft == 'txt' then
    local words = vim.fn.wordcount().words
    return ' ' .. words .. 'w'
  end
  return ''
end

vim.opt.statusline = table.concat {
  ' %t %m %r',
  ' %=',
  ' %{%v:lua.vim.diagnostic.status()%} ',
  '%{v:lua.Statusline_wordcount()}',
  '%{v:lua.git_branch()}',
}

local M = {}
local zen_active = false

local function update_visibility()
  vim.o.laststatus = (zen_active or vim.bo.filetype == 'ministarter') and 0 or 2
end

function M.set_zen(active)
  zen_active = active
  update_visibility()
end

local group = vim.api.nvim_create_augroup('user-statusline', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  group = group,
  callback = vim.schedule_wrap(update_visibility),
})
vim.api.nvim_create_autocmd('User', {
  group = group,
  pattern = 'MiniStarterOpened',
  callback = update_visibility,
})

return M
