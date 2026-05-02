-- Statusline with modular components

_G.git_branch = function()
  return vim.b.gitsigns_head or ''
end

_G.Statusline_filename = function()
  local fname = vim.fn.expand '%:t'
  return fname ~= '' and fname or '[No Name]'
end

-- LSP status: show active servers
_G.Statusline_lsp = function()
  local clients = vim.lsp.get_clients { bufnr = 0 }
  if #clients == 0 then
    return ''
  end
  local names = {}
  for _, client in ipairs(clients) do
    table.insert(names, client.name)
  end
  return '[' .. table.concat(names, ', ') .. ']'
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
  ' %{v:lua.Statusline_filename()} %m %r',
  ' %=',
  [[ %{% luaeval("(package.loaded['vim.diagnostic'] and vim.diagnostic.status(0) ~= '' and vim.diagnostic.status(0) .. ' ') or ''") %}]],
  ' %{v:lua.Statusline_lsp()}',
  '%{v:lua.Statusline_wordcount()}',
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
