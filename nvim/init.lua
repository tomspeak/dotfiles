require 'options'
require 'keybinds'
require 'autocmds'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  spec = {
    { import = 'custom.plugins' },
  },
  checker = { enabled = false },
  defaults = {
    lazy = false,
    version = false, -- always use the latest git commit
  },
  change_detection = {
    enabled = false,
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
      },
    },
  },
}

vim.cmd [[colorscheme naysayer]]
require 'statusline'
