-- local opt = vim.opt
-- local cmd = vim.api.nvim_command
local api = vim.api

-- Enable spell checking for certain file types
api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
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
    vim.highlight.on_yank()
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
