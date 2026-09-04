vim.opt_local.shiftwidth = 2
vim.opt_local.formatoptions:remove 'o'

vim.keymap.set('n', '<Leader>ch', '<cmd>ClangdSwitchSourceHeader<cr>', { buf = 0, silent = true, desc = 'Switch source/header file' })
