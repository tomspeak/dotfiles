local bufnr = vim.api.nvim_get_current_buf()

-- Rust uses apostrophes heavily for lifetimes and labels. Keep quote pairing in
-- other filetypes, but make `'` literal in Rust buffers.
require('mini.pairs').map_buf(bufnr, 'i', "'", {
  action = 'open',
  pair = "''",
  neigh_pattern = 'a^',
  register = { bs = false, cr = false },
})

local undo = [[lua require('mini.pairs').unmap_buf(0, 'i', "'", "''")]]
vim.b.undo_ftplugin = (vim.b.undo_ftplugin and vim.b.undo_ftplugin .. ' | ' or '') .. undo
