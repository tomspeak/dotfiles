vim.opt_local.shiftwidth = 2
vim.opt_local.formatoptions:remove 'o'

vim.keymap.set('n', '<Leader>ch', '<cmd>LspClangdSwitchSourceHeader<cr>', { buf = 0, silent = true, desc = 'Switch source/header file' })

vim.b.undo_ftplugin = (vim.b.undo_ftplugin and vim.b.undo_ftplugin .. ' | ' or '')
  .. 'setlocal shiftwidth< formatoptions< | silent! nunmap <buffer> <Leader>ch'
