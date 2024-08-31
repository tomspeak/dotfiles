-- vim.g.base46_cache = vim.fn.stdpath 'data' .. '/base46_cache/'

require 'options'
require 'keybinds'
require 'autocmds'

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- local integrations = require('nvconfig').base46.integrations

-- for _, name in ipairs(integrations) do
--   dofile(vim.g.base46_cache .. name)
-- end

require('lazy').setup {
  { import = 'custom.plugins' },
}
