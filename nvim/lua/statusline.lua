-- Git branch using Fugitive
local function git_branch()
  if vim.fn.exists '*FugitiveHead' == 1 then
    local branch = vim.fn.FugitiveHead()
    return branch ~= '' and branch or ''
  end
  return ''
end

-- File name
local function filename()
  local fname = vim.fn.expand '%:t'
  return fname ~= '' and fname or '[No Name]'
end

-- LSP diagnostics
local function diagnostics()
  local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  return string.format('E:%d W:%d', errors, warnings)
end

-- Final statusline
function Statusline()
  return string.format(' %s %%= %s    (%s)', filename(), diagnostics(), git_branch())
end

vim.o.statusline = '%!v:lua.Statusline()'
