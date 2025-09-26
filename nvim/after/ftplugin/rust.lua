local keymap = vim.keymap

local bufnr = vim.api.nvim_get_current_buf()

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
