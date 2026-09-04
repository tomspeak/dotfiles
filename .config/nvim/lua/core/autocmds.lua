-- Highlight yanked and pasted text
local highlight_group = vim.api.nvim_create_augroup('TextHighlight', { clear = true })
vim.api.nvim_create_autocmd({ 'TextYankPost', 'TextPutPost' }, {
  callback = function()
    vim.hl.hl_op()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.api.nvim_create_autocmd('VimResized', {
  group = vim.api.nvim_create_augroup('WinResize', { clear = true }),
  pattern = '*',
  command = 'wincmd =',
  desc = 'Auto-resize windows on terminal buffer resize.',
})

local focus_group = vim.api.nvim_create_augroup('WindowFocus', { clear = true })
local dimmed_cursorlines = {}
local function ordinary_window()
  return vim.bo.buftype == '' and vim.api.nvim_win_get_config(0).relative == ''
end

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  group = focus_group,
  callback = function()
    if not ordinary_window() then
      return
    end
    local win, buf = vim.api.nvim_get_current_win(), vim.api.nvim_get_current_buf()
    local saved = dimmed_cursorlines[win]
    if saved and saved[buf] ~= nil then
      vim.wo.cursorline = saved[buf]
      saved[buf] = nil
    end
  end,
  desc = 'Restore the active editing window cursorline preference.',
})

vim.api.nvim_create_autocmd('WinLeave', {
  group = focus_group,
  callback = function()
    if not ordinary_window() then
      return
    end
    local win, buf = vim.api.nvim_get_current_win(), vim.api.nvim_get_current_buf()
    dimmed_cursorlines[win] = dimmed_cursorlines[win] or {}
    if dimmed_cursorlines[win][buf] == nil then
      dimmed_cursorlines[win][buf] = vim.wo.cursorline
    end
    vim.wo.cursorline = false
  end,
  desc = 'Dim inactive editing windows without changing their preferences.',
})

vim.api.nvim_create_autocmd('WinClosed', {
  group = focus_group,
  callback = function(ev)
    dimmed_cursorlines[tonumber(ev.match)] = nil
  end,
})
vim.api.nvim_create_autocmd('BufWipeout', {
  group = focus_group,
  callback = function(ev)
    for _, saved in pairs(dimmed_cursorlines) do
      saved[ev.buf] = nil
    end
  end,
})

vim.api.nvim_create_augroup('Git', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Initialize a commit message once without disturbing later navigation',
  pattern = 'gitcommit',
  callback = function(ev)
    if vim.b[ev.buf].commit_initialized then
      return
    end
    vim.b[ev.buf].commit_initialized = true
    vim.api.nvim_win_set_cursor(0, { 1, 0 })
    if vim.fn.getline(1) == '' then
      vim.cmd 'startinsert!'
    end
  end,
  group = 'Git',
})

local commit_files = {
  COMMIT_EDITMSG = true,
  MERGE_MSG = true,
  SQUASH_MSG = true,
  TAG_EDITMSG = true,
  ['git-rebase-todo'] = true,
}
vim.api.nvim_create_autocmd('BufReadPost', {
  group = vim.api.nvim_create_augroup('LastPosition', { clear = true }),
  callback = function(ev)
    local name = vim.api.nvim_buf_get_name(ev.buf)
    if not ordinary_window() or name == '' or commit_files[vim.fn.fnamemodify(name, ':t')]
      or vim.bo[ev.buf].filetype == 'gitcommit' or vim.bo[ev.buf].filetype == 'gitrebase' then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(ev.buf) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
  desc = 'Restore the last editing position in ordinary files',
})

local filename_templates = {
  Makefile = 'Makefile',
  makefile = 'Makefile',
  GNUmakefile = 'Makefile',
  ['main.c'] = 'c',
  ['main.rs'] = 'rs',
  ['main.py'] = 'py',
  ['__main__.py'] = 'py',
  ['main.zig'] = 'zig',
}
local entrypoint_only = { c = true, rs = true, py = true, zig = true }
vim.api.nvim_create_autocmd('BufNewFile', {
  group = vim.api.nvim_create_augroup('Skeleton', { clear = true }),
  callback = function(ev)
    if vim.bo[ev.buf].buftype ~= '' or vim.api.nvim_buf_line_count(ev.buf) ~= 1
      or vim.api.nvim_buf_get_lines(ev.buf, 0, 1, false)[1] ~= '' then
      return
    end
    local name = vim.api.nvim_buf_get_name(ev.buf)
    local ext = vim.fn.fnamemodify(name, ':e')
    local key = filename_templates[vim.fn.fnamemodify(name, ':t')]
    if ext == 'rs' and vim.fn.fnamemodify(name, ':h:t') == 'bin' then
      key = 'rs'
    end
    key = key or (not entrypoint_only[ext] and ext or nil)
    if not key or key == '' then
      return
    end
    local template = vim.fn.stdpath 'config' .. '/templates/skeleton.' .. key
    if vim.fn.filereadable(template) == 1 then
      vim.api.nvim_buf_set_lines(ev.buf, 0, -1, false, vim.fn.readfile(template))
    end
  end,
  desc = 'Load appropriate boilerplate for empty new files and entrypoints',
})
