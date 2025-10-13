local keymap = vim.keymap.set

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable `<Space>` so we can use it as <Leader>
keymap({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
keymap('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
keymap('n', '<leader>d', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Handle navigation between windows
keymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

keymap('n', '<Esc>', function()
  vim.cmd 'noh'
  vim.lsp.buf.clear_references()
end, { desc = 'Clear highlights' })
keymap('n', ';', ':', { desc = 'Enter command mode', nowait = true })
keymap('v', ';', ':', { desc = 'Enter command mode', nowait = true })
keymap('n', '<leader>q', ':q<CR>', { desc = 'Close window' })
keymap('n', '<leader>x', '<cmd> bd <CR>', { desc = 'Close buffer' })

-- NvimTree
keymap('n', '_', '<cmd> NvimTreeFindFile <CR>', { desc = 'Nvimtree Find File', nowait = true })
keymap('n', '-', '<cmd> NvimTreeToggle <CR>', { desc = 'Nvimtree Toggle', nowait = true })

-- Aerial
keymap('n', '<C-_>', '<cmd>AerialToggle<CR>', { desc = 'Aerial Toggle' })

-- Search/Replace under current word
keymap('n', '<Leader>rr', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = 'Search & replace word under cursor', silent = false })
keymap("v", "<leader>rr", "y:%s/<C-r>0//gc<left><left><left>", { desc = "Search/replace visual" })

-- Stay in visual mode when changing indentation
keymap('v', '<', '<gv', { noremap = true, silent = true })
keymap('v', '>', '>gv', { noremap = true, silent = true })

-- Vertical split
keymap('n', '<Leader>v', vim.cmd.vsplit, { silent = true })

-- Quicker macro playback
keymap('n', 'Q', '@qj')
keymap('x', 'Q', ':norm @q<CR>')

-- themes / colors
keymap('n', '<Leader>td', ':set background=dark<CR>', { desc = 'Set background dark', noremap = true })
keymap('n', '<Leader>tl', ':set background=light<CR>', { desc = 'Set background light', noremap = true })

-- Copy file/buffer
-- copies current buffer file path relative to cwd to register
keymap('n', 'cp', function()
  local path = vim.fn.resolve(vim.fn.fnamemodify(vim.fn.expand '%', ':~:.'))
  vim.fn.setreg('+', path)
end)

-- copies current buffer filename to register
keymap('n', 'cf', function()
  local filename = vim.fn.resolve(vim.fn.fnamemodify(vim.fn.expand '%', ':t'))
  vim.fn.setreg('+', filename)
end)

-- append to end of line
keymap("n", "<Leader>,", ":normal! A,<CR>", { desc = "Append comma", silent = true })
keymap("n", "<Leader>;", ":normal! A;<CR>", { desc = "Append semicolon", silent = true })

keymap("n", "<Leader>rt", "<cmd>restart<CR>", { desc = "Restart Neovim" })
