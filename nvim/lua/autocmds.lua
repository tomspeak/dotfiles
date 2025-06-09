-- Enable spell checking for certain file types
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('edit_text', { clear = true }),
  pattern = { '*.txt', '*.md', '*.tex', '*.mdx', '*.rst', 'txt', 'gitcommit' },
  desc = 'Enable spell checking and text wrapping for certain filetypes',
  callback = function()
    vim.opt.spell = true
    vim.opt.spelllang = 'en'
  end,
})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank()
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

vim.api.nvim_create_augroup('Git', { clear = true })

vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Automatically go into insert mode + spellcheck for commit messages',
  pattern = 'COMMIT_EDITMSG',
  callback = function()
    vim.opt.spell = true

    -- Check if the buffer is empty (e.g., a new commit message)
    -- This checks for both an empty first line and if the buffer's line count is 1
    vim.api.nvim_win_set_cursor(0, { 1, 0 })
    if vim.fn.getline(1) == '' then
      vim.cmd 'startinsert!'
    end
  end,
  group = 'Git',
})
