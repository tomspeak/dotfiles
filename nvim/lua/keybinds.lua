-- Keymaps for better default experience
-- See `:help vim.keymap.set()`

-- Disable `<Space>` so we can use it as <Leader>
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Handle navigation between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<Esc>', function()
  vim.cmd 'noh'
  vim.lsp.buf.clear_references()
end, { desc = 'Clear highlights' })
vim.keymap.set('n', ';', ':', { desc = 'Enter command mode', nowait = true })
vim.keymap.set('v', ';', ':', { desc = 'Enter command mode', nowait = true })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Close window' })
vim.keymap.set('n', '<leader>x', '<cmd> bd <CR>', { desc = 'Close buffer' })

-- NvimTree
vim.keymap.set('n', '_', '<cmd> NvimTreeFindFile <CR>', { desc = 'Nvimtree Find File', nowait = true })
vim.keymap.set('n', '-', '<cmd> NvimTreeToggle <CR>', { desc = 'Nvimtree Toggle', nowait = true })

-- Aerial
vim.keymap.set('n', '<C-_>', '<cmd>AerialToggle<CR>', { desc = 'Aerial Toggle' })

-- Search/Replace under current word
vim.keymap.set('n', '<leader>rr', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set('v', '<leader>rr', [[:s///gI<Left><Left><Left><Left>]])

-- Stay in visual mode when changing indentation
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })

-- Vertical split
vim.keymap.set('n', '<Leader>v', vim.cmd.vsplit, { silent = true })

-- Quicker macro playback
vim.keymap.set('n', 'Q', '@qj')
vim.keymap.set('x', 'Q', ':norm @q<CR>')
