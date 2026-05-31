local keymap = vim.keymap

local bufnr = vim.api.nvim_get_current_buf()

-- Rust uses apostrophes heavily for lifetimes and labels. Keep quote pairing in
-- other filetypes, but make `'` literal in Rust buffers.
require('mini.pairs').map_buf(bufnr, 'i', "'", {
  action = 'open',
  pair = "''",
  neigh_pattern = 'a^',
  register = { bs = false, cr = false },
})

keymap.set(
  "n",
  "<leader>ca",
  function()
    vim.cmd.RustLsp('codeAction')
  end,
  { silent = true, buffer = bufnr }
)

keymap.set(
  "n",
  "K",
  function()
    vim.cmd.RustLsp({ 'hover', 'actions' })
  end,
  { silent = true, buffer = bufnr }
)
