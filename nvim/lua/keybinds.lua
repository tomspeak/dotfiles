-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<Esc>', '<cmd> noh <CR>', { desc = 'Clear highlights' })
vim.keymap.set('n', ';', ':', { desc = 'Enter command mode', nowait = true })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Close window' })
vim.keymap.set('n', '<leader>x', '<cmd> bd <CR>', { desc = 'Close buffer' })
vim.keymap.set('n', '<leader>X', '<cmd> BufferLineCloseOthers <CR>', { desc = 'Close all other buffers' })
vim.keymap.set('n', 'gx', '<cmd> sil !open <cWORD><cr>', { desc = 'Open link under cursor' })

vim.keymap.set('n', '-', '<cmd> NvimTreeToggle <CR>', { desc = 'Nvimtree Toggle', nowait = true })
vim.keymap.set('n', '_', '<cmd> NvimTreeFindFile <CR>', { desc = 'Nvimtree Find File', nowait = true })
vim.keymap.set('n', '<C-->', '<cmd> AerialToggle <CR>', { desc = 'Aerial Toggle' })
vim.keymap.set('n', '<tab>', '<cmd> BufferLineCycleNext <CR>', { desc = 'Goto next buffer' })
vim.keymap.set('n', '<S-tab>', '<cmd> BufferLineCyclePrev <CR>', { desc = 'Goto prev buffer' })
