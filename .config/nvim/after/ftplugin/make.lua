vim.opt_local.shiftwidth = 8
vim.opt_local.softtabstop = 0
vim.bo.expandtab = false

vim.b.undo_ftplugin = (vim.b.undo_ftplugin and vim.b.undo_ftplugin .. ' | ' or '')
  .. 'setlocal shiftwidth< softtabstop< expandtab<'
