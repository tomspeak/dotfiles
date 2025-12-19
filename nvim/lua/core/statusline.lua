-- Statusline with caching and modular components

local git_branch_cache = {}
local cache_duration = 1000 -- 1 second in ms

local function get_git_branch()
  local cwd = vim.fn.getcwd()
  local now = vim.loop.now()

  -- Return cached result if still valid
  if git_branch_cache[cwd] and (now - git_branch_cache[cwd].time) < cache_duration then
    return git_branch_cache[cwd].branch
  end

  -- Fetch fresh branch
  local handle = io.popen 'git branch --show-current 2>/dev/null'
  local branch = ''
  if handle then
    branch = handle:read '*a':gsub('\n', '')
    handle:close()
  end

  -- Cache the result
  git_branch_cache[cwd] = { branch = branch, time = now }
  return branch
end

_G.git_branch = get_git_branch

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
  ' %(%{v:lua.vim.diagnostic.status()} %)',
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
